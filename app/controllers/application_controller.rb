class ApplicationController < ActionController::Base
  before_action :initialize_cart
  before_action :initialize_categories

  def initialize_cart
    @cart = session[:cart] ||= []
  end

  def initialize_categories
    @categories = Category.all.order(:name)
  end
end
