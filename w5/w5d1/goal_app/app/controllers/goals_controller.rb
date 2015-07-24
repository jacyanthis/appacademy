class GoalsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def new
    @goal = Goal.new
  end

  def index
    @goals = Goal.where(is_private: false).all
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy
    redirect_to user_url(current_user)
  end

  private

  def goal_params
    goal_params = params[:goal].permit(:description, :is_private, :is_completed)
    goal_params[:user_id] = current_user.id
    goal_params
  end
end
