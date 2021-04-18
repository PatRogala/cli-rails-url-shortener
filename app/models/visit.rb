class Visit < ApplicationRecord
  validates :short_url, :user_id, presence: true

  belongs_to :short_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :ShortenedUrl

  belongs_to :visitor,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  def self.record_visit!(user, shortened_url)
    Visit.create!(:user_id => user.id, :short_url => shortened_url)
  end
end