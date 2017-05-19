class RestaurantsController < ApplicationController
  def index
    params.permit(:cuisine)
    return unless cuisine
    @restaurants = Restaurant.cuisine(cuisine).recently_graded.first(10)
  end

  private

  def cuisine
    return unless params[:cuisine].presence
    params[:cuisine].strip
  end
end
