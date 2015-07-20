class PostsController < ApplicationController
  before_action :user_is_author, only: [:edit, :update]

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Post created"
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id

    render :show
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Updated successsfully"
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private
    def post_params
      post_params = params.require(:post).permit(:title, :url, :content, sub_ids: [])
      post_params[:author_id] = current_user.id
      post_params
    end

    def user_is_author
      unless current_user.id == Post.find(params[:id]).author_id
        flash[:errors] = ["You must be the author to edit a post."]
        redirect_to :back
      end
    end
end
