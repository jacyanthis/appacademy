class GoalCommentsController < ApplicationController
  def new
    @goal_comment = GoalComment.new
  end

  def create
    @goal_comment = GoalComment.new(goal_comment_params)
    unless @goal_comment.save
      flash[:errors] = @goal_comment.errors.full_messages
    end
    redirect_to :back
  end

  private

  def goal_comment_params
    attributes = params.require(:goal_comment).permit(:body, :goal_id)
    attributes[:author_id] = current_user.id

    attributes
  end
end
