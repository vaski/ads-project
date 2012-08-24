class AdsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [ :edit, :update, :destroy ]

  def new
    @ad = current_user.ads.build
  end

  def edit
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

  def update
    if @ad.update_attributes(params[:ad])
      flash[:success] = "Ad updated!"
      redirect_to current_user
    else
      flash.now[:error] = "Ad not updated!"
      render 'edit'
    end
  end

  def destroy
    @ad.destroy
    redirect_to current_user
  end

  private

  def correct_user
    @ad = current_user.ads.find(params[:id])
  rescue
    render(file: File.join(Rails.root, 'public/422.html'), status: 403,
                                                           layout: false)
  end
end
