# == Schema Information
#
# Table name: taggings
#
#  id          :integer          not null, primary key
#  url_id      :integer
#  tagtopic_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Tagging < ActiveRecord::Base
  belongs_to(
    :tagtopic,
    foreign_key: :tagtopic_id,
    primary_key: :id,
    class_name: :Tagtopic
  )
  belongs_to(
    :shortened_url,
    foreign_key: :url_id,
    primary_key: :id,
    class_name: :ShortenedUrl
  )
end
