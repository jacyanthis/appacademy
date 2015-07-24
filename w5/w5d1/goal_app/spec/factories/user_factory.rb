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

FactoryGirl.define do
  factory :user do
    username "testing_username"
    password "biscuits"

    factory :other_user do
      username "other_user"
      password "other_user_pass"
    end
  end
end
