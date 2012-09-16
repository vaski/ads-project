class AdsController < ApplicationController
  load_and_authorize_resource

  def index
    @ads = @ads.where(state: 'published').paginate(page: params[:page],
                                                   include: :images)
  end

  def create
    @ad = current_user.ads.build(params[:ad])
    if @ad.save
      flash[:success] = "Ad created!"
      redirect_to @ad
    else
      flash.now[:error] = "Ad not created!"
      render 'new'
    end
  end

  def new
    @ad.images.build
  end

  def update
    if @ad.update_attributes(params[:ad])
      flash[:success] = "Ad updated!"
      redirect_to ad_path
    else
      flash.now[:error] = "Ad not updated!"
      render 'edit'
    end
  end

  def destroy
    @ad.destroy
    flash[:notice] = "Successfuly destroyed ad!"
    redirect_to current_user
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
