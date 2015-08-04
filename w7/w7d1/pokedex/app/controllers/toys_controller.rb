class ToysController < ApplicationController
  def create
    @toy = Toy.new(toy_params)
    if @toy.save
      render "show"
    else
      render json: @toy.errors.full_messages, status: 422
    end
  end

  def update
    @toy = Toy.find(params[:id])
    if @toy.update(toy_params)
      render 'show'
    else
      render json: @toy.errors.full_messages, status: 422
    end
  end

  def destroy
    @toy = Toy.find(params[:id])
    @toy.destroy
    render 'show'
  end

  private

  def toy_params
    params.require(:toy).permit(:pokemon_id, :name, :price, :happiness, :image_url)
  end
end
