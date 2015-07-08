class Reply
  extend CommonClassMethods
  include Save

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_parent_id(parent_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    replies.map { |reply| Reply.new(reply) }
  end

  attr_accessor :id, :body, :question_id, :parent_id, :user_id

  def initialize(options)
    @id, @body, @question_id, @parent_id, @user_id =
      options["id"], options["body"], options["question_id"],
      options["parent_id"], options["user_id"]
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    Reply.find_by_id(parent_id)
  end

  def child_replies
    Reply.find_by_parent_id(id)
  end
end
