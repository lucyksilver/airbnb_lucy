class FlatsController < ApplicationController
  def index
    if params[:query]
      @flats = Flat.search_by_name_and_address(params[:query])
    else
    @flats = Flat.all
  end
  end

  def show
    @flat = Flat.find(params[:id])
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  def edit
    @flat = Flat.find(params[:id])

  end

  def update
    @flat = Flat.find(params[:id])
    @flat.update(flat_params)
    redirect_to flat_path(@flat)
  end

  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy
  end

private

  def flat_params
    params.require(:flat).permit(:name, :address)
  end
end
