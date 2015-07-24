FactoryGirl.define do
  factory :goal do
    description "this is user's random goal"
    is_private [true, false].sample
    is_completed [true, false].sample
    user

    factory :private_goal do
      description "this is user's private goal"
      is_private true
    end

    factory :public_goal do
      description "this is user's public goal"
      is_private false
    end

    factory :other_private_goal do
      description "this is other user's private goal"
      is_private true
      association :user, factory: :other_user
    end

    factory :other_public_goal do
      description "this is other user's public goal"
      is_private false
      association :user, factory: :other_user
    end

    factory :completed_goal do
      description "this is user's completed goal"
      is_completed true
    end

    factory :uncompleted_goal do
      description "this is user's uncompleted goal"
      is_completed false
    end

  end
end
