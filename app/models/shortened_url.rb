class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, uniqueness: true, presence: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :user

  has_many :taggings,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Tagging

  has_many :tags,
    through: :taggings,
    source: :tag

  def self.random_code
    random_string = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: random_string)
      random_string = SecureRandom.urlsafe_base64
    end
    random_string
  end

  def self.create!(user, long_url)
    s = ShortenedUrl.new(user_id: user.id, short_url: self.random_code, long_url: long_url)
    s.save
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.select(:user_id).count
  end

  def num_recent_uniques
    uniq_visits = self.visits.select(:user_id)
    uniq_visits.where("visits.created_at > ?", 10.minutes.ago).distinct.count
  end
end
