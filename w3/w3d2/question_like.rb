class QuestionLike
  extend CommonClassMethods
  include Save

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes
      ON
        question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
    users.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(question_id)
    QuestionsDatabase.instance.get_first_value(<<-SQL, question_id)
      SELECT
        COUNT(*) as count
      FROM
        users
      JOIN
        question_likes
      ON
        question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes
      ON
        question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL
    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_likes.id)
      LIMIT
        ?
    SQL
    questions.map { |question| Question.new(question)}
  end

  attr_accessor :id, :question_id, :user_id

  def initialize(options)
    @id, @question_id, @user_id =
      options["id"], options["question_id"], options["user_id"]
  end
end
