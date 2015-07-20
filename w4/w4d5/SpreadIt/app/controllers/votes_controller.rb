class VotesController < ApplicationController
  def upvote
    @vote = Vote.new(value: 1, user_id: current_user.id,
      votable_id: get_votable_id, votable_type: get_votable_type)
    if @vote.save
      flash[:notice] = "Thanks for the vote!"
      redirect_to :back
    else
      flash[:errors] = @vote.errors.full_messages
      redirect_to :back
    end
  end

  def downvote
    @vote = Vote.new(value: -1, user_id: current_user.id,
      votable_id: get_votable_id, votable_type: get_votable_type)
    if @vote.save
      flash[:notice] = "Thanks for the vote!"
      redirect_to :back
    else
      flash[:errors] = @vote.errors.full_messages
      redirect_to :back
    end
  end

  private
  def get_votable_id
    params[:post_id] ? params[:post_id] : params[:comment_id]
  end

  def get_votable_type
    params[:post_id] ? "Post" : "Comment"
  end
end
