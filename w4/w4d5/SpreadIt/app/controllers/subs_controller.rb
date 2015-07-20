class SubsController < ApplicationController
  before_action :user_is_moderator, only: [:edit, :update]

  def create
    @sub = Sub.new(sub_params)

    if @sub.save
      flash[:notice] = "Sub created"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def index
    @subs = Sub.all
    render :index
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      flash[:notice] = "Updated successsfully"
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  private
    def sub_params
      sub_params = params.require(:sub).permit(:title, :description)
      sub_params[:moderator_id] = current_user.id
      sub_params
    end

    def user_is_moderator
      unless current_user.id == Sub.find(params[:id]).moderator_id
        flash[:errors] = ["You must be the moderator to edit a subspreadit."]
        redirect_to :back
      end
    end
end
