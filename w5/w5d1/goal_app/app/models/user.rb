# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token

  has_many :goals

  has_many(
    :authored_user_comments,
    class_name: "UserComment",
    foreign_key: :author_id
  )

  has_many(
    :authored_goal_comments,
    class_name: "GoalComment",
    foreign_key: :author_id
  )

  has_many(
    :received_user_comments,
    class_name: "UserComment"
  )

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = self.find_by(username: username)
    (user && user.valid_password?(password)) ? user : nil
  end

  def valid_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def public_goals
    goals.where(is_private: false)
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end
