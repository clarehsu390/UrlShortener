class TagTopic < ActiveRecord::Base
  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: :Tagging

  has_many :urls,
    through: :taggings,
    source: :url

  def create!(topic)
    TagTopic.create!(topic: topic)
  end

  def popular_links
    
  end
end
