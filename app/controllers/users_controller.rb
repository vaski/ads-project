class UsersController < ApplicationController
  load_and_authorize_resource except: :create
  skip_authorize_resource only: :index

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
    role_param = params[:user][:role]
    params[:user].delete(:role)
    @user = User.new(params[:user])
    authorize! :create, @user
    @user.role = role_param if can? :assign_role, @user
    if @user.save
      flash[:success] = "User created!"
      redirect_to users_path
    else
      flash.now[:error] = "User not created!"
      render 'new'
    end
  end

  def update
    role_param = params[:user][:role]
    @user.role = role_param if can? :assign_role, @user
    if @user.update_attributes(params[@user])
      flash[:success] = "User updated!"
      redirect_to users_path
    else
      flash.now[:error] = "User not updated!"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User destroyed!"
    redirect_to users_path
  end
end
