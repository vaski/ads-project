class PagesController < ApplicationController
  def verified_ads
    @ads = Ad.where(state: 'verified').paginate(page: params[:page],
                                                per_page: 5,
                                                include: [:images, :categories])
    authorize! :create, Category
  end
end
