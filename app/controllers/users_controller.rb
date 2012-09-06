class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @ads = @user.ads.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed!"
    redirect_to users_path
  end
end
