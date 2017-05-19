class RestaurantsController < ApplicationController
  def index
    params.permit(:cuisine)
    return unless cuisine

    @results = Restaurant.cuisine(cuisine).recently_graded.first(10)

    @results.presence or
      @error_message = error_message
  end

  private

  def cuisine
    return unless params[:cuisine].presence
    params[:cuisine].strip
  end

  def error_message
    "Sorry, no restaurants found. Please try another type of cuisine!"
  end
end
