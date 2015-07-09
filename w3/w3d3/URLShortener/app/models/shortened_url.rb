# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  belongs_to(
    :submitter,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: :User
  )

  has_many(
    :visits,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: :Visit
  )

  has_many(
    :visitors,
    -> { distinct },
    through: :visits,
    source: :user
  )

  has_many(
    :taggings,
    foreign_key: :url_id,
    primary_key: :id,
    class_name: :Tagging
  )

  has_many(
    :tagtopics,
    through: :taggings,
    source: :tagtopic
  )

  has_many(
    :votes,
    foreign_key: :url_id,
    primary_key: :id,
    class_name: :Vote
  )

  validates(
    :short_url,
    :presence => true,
    :uniqueness => true
  )
  validates(
    :long_url,
    :presence => true,
    :uniqueness => true,
    :length => { :maximum => 255 }
  )
  validates(
    :submitter_id,
    :presence => true
  )

  validate :no_more_than_five_in_last_minute
  validate :no_more_than_five_for_non_premium

  def self.random_code
    random_code = SecureRandom.urlsafe_base64
    raise "random_code already used" if self.exists?(:short_url => random_code)
    random_code
  rescue
    retry
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: self.random_code
    )
  end

  def self.create_custom_url!(user, long_url, desired_short_url)
    raise "you aren't allowed to do that" unless user.premium
    self.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: desired_short_url
    )
  end

  def self.prune(n)
    # all visits are old
    self.joins(:visits)
     .group("shortened_urls.id")
     .having("MAX(visits.created_at) < ?", n.minutes.ago)
     .destroy_all

    # never-visited urls
    self.joins("LEFT OUTER JOIN visits ON shortened_urls.id = visits.shortened_url_id")
      .group("shortened_urls.id")
      .having("COUNT(visits.id) = 0")
      .destroy_all
  end

  def self.top
    self.joins(:votes)
      .group("shortened_urls.id")
      .order("COUNT(votes.id) DESC")
  end

  def self.hot(n)
    self.joins(:votes)
      .group("shortened_urls.id")
      .having("votes.created_at > ?", n.minutes.ago)
      .order("COUNT(votes.id) DESC")
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.where("created_at > ?", 10.minutes.ago).distinct.count
  end

  private
  def no_more_than_five_in_last_minute
    if User.find_by_id(submitter_id).num_recent_submitted_urls >= 5
      errors[:submitter_id] << "already five submissions in last minute"
    end
  end

  def no_more_than_five_for_non_premium
    user = User.find_by_id(submitter_id)
    if user.submitted_urls.count >= 5 && !user.premium
      errors[:submitter_id] << "please purchase a premium membership to create more urls"
    end
  end
end
