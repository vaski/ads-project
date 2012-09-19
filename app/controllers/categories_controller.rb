class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = @categories.paginate(page: params[:page], include: :categorizations)
  end

  def create
    if @category.save
      flash[:success] = "Category created!"
      redirect_to categories_path
    else
      flash.now[:error] = "Category not created!"
      render 'new'
    end
  end

  def update
    if @category.update_attributes(params[:category])
      flash[:success] = "Category updated!"
      redirect_to categories_path
    else
      flash.now[:error] = "Category not updated!"
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "Category destroyed!"
    redirect_to categories_path
  end
end
