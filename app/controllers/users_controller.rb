class UsersController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  def index
    @users = @users.paginate(page: params[:page])
    authorize! :update, User
  end

  def show
    @ads = @user.ads.paginate(page: params[:page],
                              per_page: 5,
                              include: [:images, :categories])
  end

  def create
    @user.role = params[:user][:role] if can? :assign_role, @user
    flash[:success] = 'User created!' if @user.save
    respond_with @user
  end

  def update
    @user.role = params[:user][:role] if can? :assign_role, @user
    flash[:success] = 'User updated!' if @user.save
    respond_with @user
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User destroyed!'
  end
end
