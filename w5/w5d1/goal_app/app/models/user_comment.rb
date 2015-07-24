class UserComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: "User"
  validates :user, :author, :body, presence: true

  

end
