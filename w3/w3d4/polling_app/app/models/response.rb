# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ActiveRecord::Base
  # validates :answer_choice, presence: true
  # validates :respondent, presence: true
  # validate :respondent_has_not_already_answered_question
  # validate :not_rigged

  belongs_to(
    :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_choice_id
    # inverse_of: :responses
  )

  belongs_to(
    :respondent,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id
    # inverse_of: :responses
  )

  has_one :question, through: :answer_choice, source: :question
  has_one :poll, through: :question, source: :poll
  # has_one :poll_author, through: :poll, source: :author

  def poll_debug
    debugger
    poll
  end

  # def sibling_responses
  #   question.responses.where(":id IS NULL OR responses.id != :id", id: self.id)
  # end
  #
  # def respondent_has_not_already_answered_question
  #   if sibling_responses.where(user_id: user_id).exists?
  #     errors[:response] << "Cannot respond to the question more than once"
  #   end
  # end
  #
  # def not_rigged
  #   puts "poll is #{poll}"
  #   puts
  #   puts
  #   puts "****"
  #   if question.poll.author_id == user_id
  #     errors[:response] << "Cannot vote for a poll you created"
  #   end
  # end


end
