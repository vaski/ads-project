class AdsController < ApplicationController
  before_filter :signed_in_user

  def create
    @ad = current_user.ads.build(params[:ad])
    if @ad.save
      flash[:success] = "Ad created"
      redirect_to user_path
    else
      render 'users/show'
    end
  end

  def destroy

  end
end
