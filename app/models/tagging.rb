class Tagging < ActiveRecord::Base
  belongs_to :tag,
  primary_key: :id,
  foreign_key: :tag_topic_id,
  class_name: :TagTopic

  belongs_to :url,
  primary_key: :id,
  foreign_key: :url_id,
  class_name: :ShortenedUrl

  def self.tag!(tag, shortened_url)
    Tagging.create!(tag_topic_id: tag.id, url_id: shortened_url.id)
  end

end
