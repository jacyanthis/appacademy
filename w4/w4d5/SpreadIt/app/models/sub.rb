# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base

  belongs_to :moderator, foreign_key: :moderator_id

  has_many :post_subs, dependent: :destroy
  has_many :posts, through: :post_subs
end
