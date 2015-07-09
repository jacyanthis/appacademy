# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#  premium    :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  has_many(
    :submitted_urls,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: :ShortenedUrl
  )

  has_many(
    :visits,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Visit
  )

  has_many(
    :visited_urls,
    -> { distinct },
    through: :visits,
    source: :shortened_url
  )

  validates :email, :presence => true, :uniqueness => true

  def num_recent_submitted_urls
    submitted_urls.where("created_at > ?", 1.minutes.ago).count
  end
end
