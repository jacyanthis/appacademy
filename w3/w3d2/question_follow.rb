class QuestionFollow
  extend CommonClassMethods
  include Save

  def self.followers_for_question_id(question_id)
    question_follows = (QuestionsDatabase.instance.execute(<<-SQL, question_id))
      SELECT
        *
      FROM
        question_follows
      WHERE
        question_id = ?
    SQL
    question_follows.map do |question_follow|
      User.find_by_id(question_follow["user_id"])
    end
  end

  def self.followed_questions_for_user_id(user_id)
    question_follows = (QuestionsDatabase.instance.execute(<<-SQL, user_id))
      SELECT
        *
      FROM
        question_follows
      WHERE
        user_id = ?
    SQL
    question_follows.map do |question_follow|
      Question.find_by_id(question_follow["question_id"])
    end
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_follows.id)
        LIMIT ?
    SQL
    questions.map { |question| Question.new(question)}
  end

  attr_accessor :id, :user_id, :question_id

  def initialize(options)
    @id, @user_id, @question_id =
      options["id"], options["user_id"], options["question_id"]
  end
end
