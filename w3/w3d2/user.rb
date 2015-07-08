class User
  extend CommonClassMethods
  include Save

  def self.find_by_name(fname, lname)
    users = (QuestionsDatabase.instance.execute(<<-SQL, fname, lname))
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    users.map { |user| User.new(user) }
  end

  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id, @fname, @lname = options["id"], options["fname"], options["lname"]
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    QuestionsDatabase.instance.get_first_value(<<-SQL, id)
      SELECT
        CAST(COUNT(question_likes.id) AS FLOAT) / COUNT(DISTINCT(questions.id))
        AS ave_karma
      FROM
        questions
      LEFT JOIN
        question_likes
      ON
        question_likes.question_id = questions.id
      WHERE
        questions.author_id = ?
    SQL
  end
end
