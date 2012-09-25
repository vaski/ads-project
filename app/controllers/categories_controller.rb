class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = @categories.paginate(page: params[:page],
                                       include: :categorizations)
  end

  def create
    if @category.save
      redirect_to categories_path, notice: 'Category created!'
    else
      render 'new'
    end
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to categories_path, notice: 'Category updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: 'Category destroyed!'
  end
end
