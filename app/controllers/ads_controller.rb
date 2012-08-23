class AdsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

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
    @ad.destroy
    redirect_to current_user
  end

  private

  def correct_user
    @ad = current_user.ads.find_by_id(params[:id])
    redirect_to current_user if @ad.nil?
  end
end
