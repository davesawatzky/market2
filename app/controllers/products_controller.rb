class ProductsController < ApplicationController
  before_action :load_cart

  def index
    @products = Product.order(:name).page(params[:page])
    @categories = Category.order(:name)
  end

  def show
    @product = Product.find(params[:id])
  end

  def on_sale
    @products = Product.where("on_sale = true").order(:name).page(params[:page])
  end

  def recent_updates
    @products = Product.where(floor_date: (Time.zone.now.midnight - 30.days)..).order(:name).page(params[:page])
  end

  def search_results
    keyword = "%#{params[:search_keywords]}%"
    if params[:with_category] == "1"
      category = params[:category_id]
      @products = Product.where("name LIKE ? AND category_id = ?", keyword,
                                category).order(:name).page(params[:page])
    else
      @products = Product.where("name LIKE ?", keyword).order(:name).page(params[:page])
    end
  end

  def add_to_cart
    quantity = params[:quantity].to_i
    id = params[:id].to_i
    session[:cart].push(id:, quantity:) unless session[:cart].include?({ id:, quantity: })
    redirect_to root_path
  end

  def remove_from_cart
    id = params[:id].to_i
    item_index = session[:cart].index { |item| item["id"] == id }
    session[:cart].delete_at(item_index)
    redirect_to root_path
  end

  private

  def load_cart
    cart_array = []
    session[:cart].each do |item|
      cart_array.push(item["id"])
    end
    @cart = Product.find(cart_array)
  end
end
