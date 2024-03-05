class CartController < ApplicationController
  before_action :load_cart

  def index
    @render_cart = false
  end

  def show
    @render_cart = false
  end

  def update_quantity
    quantity = params[:quantity].to_i
    id = params[:id].to_i
    product_index = session[:cart].index { |product| product["id"] == id }
    session[:cart][product_index]["quantity"] = quantity
    redirect_to "/cart"
  end

  def remove
    id = params[:id].to_i
    item_index = session[:cart].index { |item| item["id"] == id }
    session[:cart].delete_at(item_index)
    redirect_to "/cart"
  end

  private

  def load_cart
    @cart = session[:cart]
  end
end
