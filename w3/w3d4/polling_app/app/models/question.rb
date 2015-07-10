# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text             not null
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  validates :poll, presence: true

  has_many(
    :answer_choices,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :question_id
    # inverse_of: :question
  )

  belongs_to(
    :poll,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :poll_id
    # inverse_of: :questions
  )

  has_many :responses, through: :answer_choices, source: :responses

  # def results
  #   coll_answer_choices = answer_choices.includes(:responses)
  #
  #   results = {}
  #   coll_answer_choices.each do |choice|
  #     results[choice.text] = choice.responses.length
  #   end
  #
  #   results
  # end

  # def results
  #   query_results = AnswerChoice.find_by_sql([<<-SQL, id])
  #     SELECT
  #       answer_choices.*, COUNT(responses.id) AS response_count
  #     FROM
  #       answer_choices
  #     LEFT JOIN
  #       responses
  #     ON
  #       answer_choices.id = responses.answer_choice_id
  #     GROUP BY
  #       answer_choices.id
  #     HAVING
  #       answer_choices.question_id = ?
  #   SQL
  #
  #   results = {}
  #   query_results.each do |choice|
  #     results[choice.text] = choice.response_count
  #   end
  #
  #   results
  # end

  def results
    answer_choices.select("answer_choices.*, COUNT(responses.id) AS response_count")
      .
  end
end
