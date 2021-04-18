require 'securerandom'

class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true
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
    source: :visitor

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.where(:created_at => 10.minutes.ago..Time.now).select(:user_id).distinct.count
  end

  def self.create_url(user, long_url)
    ShortenedUrl.create!(
      :long_url => long_url,
      :short_url => ShortenedUrl.random_code,
      :user_id => user.id
    )
  end

  private
  def self.random_code
    code = SecureRandom.urlsafe_base64
    code = SecureRandom.urlsafe_base64 while ShortenedUrl.exists?(:short_url => code)
    code
  end
end