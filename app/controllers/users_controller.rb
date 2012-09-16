class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.paginate(page: params[:page])
  end

  def show
    @ads = @user.ads.paginate(page: params[:page], include: :images)
  end

  def destroy
    @user.destroy
    flash[:success] = "User destroyed!"
    redirect_to users_path
  end
end
