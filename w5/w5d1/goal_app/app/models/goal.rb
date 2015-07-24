# == Schema Information
# Table name: goals
#
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  description  :string           not null
#  is_private   :boolean          default(TRUE), not null
#  is_completed :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Goal < ActiveRecord::Base
  belongs_to :user
  validates :user, :description, presence: true
  validates :is_private, inclusion: [true, false]
  validates :is_completed, inclusion: [true, false]

  has_many(
    :comments,
    class_name: "GoalComment"
  )

end
