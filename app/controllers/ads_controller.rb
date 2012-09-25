class AdsController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  def index
    @ads = @ads.published.paginate(page: params[:page],
                                   per_page: 5,
                                   include: [:images, :categories] )
  end

  def create
    @ad = current_user.ads.build(params[:ad])
    flash[:success] = 'Ad created!' if @ad.save
    respond_with @ad
  end

  def new
    @ad.images.build
  end

  def update
    flash[:success] = 'Ad updated!' if @ad.update_attributes(params[:ad])
    respond_with @ad
  end

  def destroy
    @ad.destroy
    redirect_to current_user, notice: 'Successfuly destroyed ad!'
  end

  def verify
    @ad.verify
    render 'show'
  end

  def approve
    @ad.approve
    render 'show'
  end

  def reject
    @ad.reject
    render 'show'
  end
end
