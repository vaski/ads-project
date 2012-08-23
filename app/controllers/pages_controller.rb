class PagesController < ApplicationController
  def home
    @ads = Ad.paginate(page: params[:page])
  end
end
