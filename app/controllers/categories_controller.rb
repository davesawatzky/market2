class CategoriesController < ApplicationController
  def index; end

  def show
    @category = Category.find(params[:id])
    @products = Product.where(category: @category).order(:name).page(params[:page])
  end
end
