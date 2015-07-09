class Vote < ActiveRecord::Base
  belongs_to(
    :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User
  )

  belongs_to(
    :url,
    foreign_key: :url_id,
    primary_key: :id,
    class_name: :ShortenedUrl
  )

  validate :no_multiple_voting
  validate :no_self_voting

  private
  def no_multiple_voting
    if Vote.all.any? { |vote| vote.user_id == self.user_id && vote.url_id == self.url_id }
      errors[:user_id] << "you can only vote for the same url once!"
    end
  end

  def no_self_voting
    if User.find_by_id(user_id).submitted_urls.include?(ShortenedUrl.find_by_id(url_id))
      errors[:user_id] << "you cannot vote for your own url!"
    end
  end
end
