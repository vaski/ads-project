class AdsController < ApplicationController
  before_filter :signed_in_user

  def new
    @ad = current_user.ads.build if signed_in?
  end

  def create
    @ad = current_user.ads.build(params[:ad])
    if @ad.save
      flash[:success] = "Ad created!"
      redirect_to current_user
    else
      flash.now[:error] = "Ad not created!"
      render 'new'
    end
  end

  def destroy

  end
end
