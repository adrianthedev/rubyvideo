# rubocop:disable Layout/LineLength
# == Schema Information
#
# Table name: talks
#
#  id             :integer          not null, primary key
#  title          :string           default(""), not null
#  description    :text             default(""), not null
#  slug           :string           default(""), not null
#  video_id       :string           default(""), not null
#  video_provider :string           default(""), not null
#  thumbnail_sm   :string           default(""), not null
#  thumbnail_md   :string           default(""), not null
#  thumbnail_lg   :string           default(""), not null
#  year           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  event_id       :integer
#  thumbnail_xs   :string           default(""), not null
#  thumbnail_xl   :string           default(""), not null
#  date           :date
#  like_count     :integer
#  view_count     :integer
#
# rubocop:enable Layout/LineLength
class Talk < ApplicationRecord
  extend ActiveJob::Performs
  include Sluggable
  include Suggestable
  slug_from :title

  # include MeiliSearch
  include MeiliSearch::Rails
  ActiveRecord_Relation.include Pagy::Meilisearch
  extend Pagy::Meilisearch

  # associations
  belongs_to :event, optional: true
  has_many :speaker_talks, dependent: :destroy, inverse_of: :talk, foreign_key: :talk_id
  has_many :speakers, through: :speaker_talks

  serialize :transcript, coder: TranscriptSerializer

  # validations
  validates :title, presence: true

  # delegates
  delegate :name, to: :event, prefix: true, allow_nil: true

  # jobs
  performs :update_transcript!, queue_as: :low do
    retry_on StandardError, wait: :polynomially_longer
  end

  # search
  meilisearch do
    attribute :title
    attribute :description
    attribute :slug
    attribute :video_id
    attribute :video_provider
    attribute :thumbnail_sm
    attribute :thumbnail_md
    attribute :thumbnail_lg
    attribute :speaker_names do
      speakers.pluck(:name)
    end
    attribute :event_name do
      event_name
    end
    attribute :transcript do
      transcript.to_text
    end
    searchable_attributes [:title, :description, :speaker_names, :event_name, :transcript]
    sortable_attributes [:title]

    attributes_to_highlight ["*"]
  end

  meilisearch enqueue: true

  # ensure that during the reindex process the associated records are eager loaded
  scope :meilisearch_import, -> { includes(:speakers, :event) }

  def to_meta_tags
    {
      title: title,
      description: description,
      og: {
        title: title,
        type: :website,
        image: {
          _: thumbnail_lg,
          alt: title
        },
        description: description,
        site_name: "RubyVideo.dev"
      },
      twitter: {
        card: "summary_large_image",
        site: "adrienpoly",
        title: title,
        description: description,
        image: {
          src: thumbnail_lg
        }
      }
    }
  end

  def thumbnail_xs
    self[:thumbnail_xs].presence || "https://i.ytimg.com/vi/#{video_id}/default.jpg"
  end

  def thumbnail_sm
    self[:thumbnail_sm].presence || "https://i.ytimg.com/vi/#{video_id}/mqdefault.jpg"
  end

  def thumbnail_md
    self[:thumbnail_md].presence || "https://i.ytimg.com/vi/#{video_id}/hqdefault.jpg"
  end

  def thumbnail_lg
    self[:thumbnail_lg].presence || "https://i.ytimg.com/vi/#{video_id}/sddefault.jpg"
  end

  def thumbnail_xl
    self[:thumbnail_xl].presence || "https://i.ytimg.com/vi/#{video_id}/maxresdefault.jpg"
  end

  def related_talks(limit: 6)
    Talk.order("RANDOM()").excluding(self).limit(limit)
  end

  def update_transcript!
    youtube_transcript = Youtube::Transcript.get(video_id)
    update!(transcript: Transcript.create_from_youtube_transcript(youtube_transcript))
  end
end
