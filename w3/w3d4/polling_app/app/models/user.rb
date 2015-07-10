# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base

  has_many(
    :responses,
    class_name: :Response,
    primary_key: :id,
    foreign_key: :user_id,
    # inverse_of: :respondent
  )

  has_many(
    :authored_polls,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :author_id
    # inverse_of: :author
  )

  has_many :questions, through: :authored_polls, source: :questions
  has_many :answer_choices, through: :questions, source: :answer_choices
end
