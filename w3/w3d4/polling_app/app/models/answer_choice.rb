# == Schema Information
#
# Table name: answer_choices
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  text       :text             not null
#

class AnswerChoice < ActiveRecord::Base
  validates :question, presence: true

  belongs_to(
    :question,
    class_name: :Question,
    primary_key: :id,
    foreign_key: :question_id
    # inverse_of: :answer_choices
  )

  has_many(
    :responses,
    class_name: :Response,
    primary_key: :id,
    foreign_key: :answer_choice_id
    # inverse_of: :answer_choice
  )
end
