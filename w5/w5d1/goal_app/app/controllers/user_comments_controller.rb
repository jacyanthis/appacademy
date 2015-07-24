class UserCommentsController < ApplicationController
  def new
    @user_comment = UserComment.new
  end

  def create
    @user_comment = UserComment.new(user_comment_params)
    unless @user_comment.save
      flash[:errors] = @user_comment.errors.full_messages
    end
    redirect_to :back
  end

  private

  def user_comment_params
    attributes = params.require(:user_comment).permit(:body, :user_id)
    attributes[:author_id] = current_user.id

    attributes
  end
end
