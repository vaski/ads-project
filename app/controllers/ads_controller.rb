class AdsController < ApplicationController
  load_and_authorize_resource

  def index
    @ads = @ads.paginate(page: params[:page])
  end

  def create
    @ad = current_user.ads.build(params[:ad])
    if @ad.save
      flash[:success] = "Ad created!"
      render 'show'
    else
      flash.now[:error] = "Ad not created!"
      render 'new'
    end
  end

  def update
    if @ad.update_attributes(params[:ad])
      flash[:success] = "Ad updated!"
      render 'show'
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
end
