class GoalComment < ActiveRecord::Base
  belongs_to :goal
  belongs_to :author, class_name: "User"
  validates :goal, :author, :body, presence: true

end
