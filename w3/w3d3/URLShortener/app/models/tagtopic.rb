# == Schema Information
#
# Table name: tagtopics
#
#  id         :integer          not null, primary key
#  topic      :string
#  created_at :datetime
#  updated_at :datetime
#

class Tagtopic < ActiveRecord::Base
  has_many(
    :taggings,
    foreign_key: :tagtopic_id,
    primary_key: :id,
    class_name: :Tagging
  )

  has_many(
    :urls,
    through: :taggings,
    source: :shortened_url
  )

  def most_popular_urls(n)
    urls.joins(:visits).group("url_id").order("COUNT(*) DESC").limit(n)
  end

  validates :topic, presence: true
end
