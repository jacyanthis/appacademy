class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = "Comment posted!"
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def new
    @comment = Comment.new
    render :new
  end

  def show
    @comment = Comment.find(params[:id])
    @all_comments = @comment.post.comments_by_parent_id
    render :show
  end

  private
    def comment_params
      comment_params = params.require(:comment).permit(:content, :post_id, :parent_comment_id)
      comment_params[:author_id] = current_user.id
      comment_params
    end
end
