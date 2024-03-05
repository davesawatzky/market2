class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :load_cart

  def create_orders
    checkout
    date = DateTime.now.strftime("%d/%m/%Y %H:%M")
    transaction_number = rand(100_000_000..199_999_999)
    customer = Customer.find(current_customer[:id])
    Order.create(
      customer:,
      subtotal:           @order_totals[:subtotal],
      shipping_cost:      @order_totals[:shipping_cost],
      totalPST:           @order_totals[:total_PST],
      totalGST:           @order_totals[:total_GST],
      totalHST:           @order_totals[:total_HST],
      total_cost:         @order_totals[:total_cost],
      paid:               true,
      transaction_number:,
      delivered:          false,
      date_submitted:     date,
      date_delivered:     ""
    )
    order_record = Order.last
    @products.each do |product|
      current_product = @product_totals.find { |item| item[:id] == product[:id] }
      Rails.logger.debug { "Current Product: #{current_product}" }
      OrderProduct.create(
        order:          order_record,
        product:,
        quantity:       current_product[:quantity],
        price_per_item: product[:price],
        subtotal:       current_product[:subtotal],
        GST:            current_product[:GST],
        PST:            current_product[:PST],
        HST:            current_product[:HST]
      )
    end
    redirect_to purchase_confirmation_path
  end

  def checkout
    @render_cart = false
    cart_array = @cart.pluck("id")
    @products = Product.find(cart_array)
    @customer = Customer.find(current_customer[:id])

    product_costs
    full_order_totals
  end

  def product_costs
    @product_totals = []
    @products.each do |product|
      cost = Hash[]
      cost[:id] = product[:id]
      index = @cart.index { |el| el["id"] == product["id"] }
      cost[:quantity] = @cart[index]["quantity"]
      cost[:HST] = if product[:taxable_HST] && @customer.province[:HST]
                     (product[:price] * (@customer.province[:HST] / 100.0) * cost[:quantity]).round(2)
                   else
                     0.00
                   end
      cost[:GST] = if product[:taxable_GST] && @customer.province[:GST]
                     (product[:price] * (@customer.province[:GST] / 100.0) * cost[:quantity]).round(2)
                   else
                     0.00
                   end
      cost[:PST] = if product[:taxable_PST] && @customer.province[:PST]
                     (product[:price] * (@customer.province[:PST] / 100.0) * cost[:quantity]).round(2)
                   else
                     0.00
                   end
      cost[:subtotal] = (product[:price] * cost[:quantity]).round(2)
      cost[:total] = cost[:subtotal] + cost[:HST] + cost[:GST] + cost[:PST]
      @product_totals.push(cost)
    end
  end

  def full_order_totals
    subtotal =      0.00
    total_GST =     0.00
    total_PST =     0.00
    total_HST =     0.00
    shipping_cost = 15.00
    total_cost =    0.00

    @product_totals.each do |cost|
      subtotal +=   cost[:subtotal]
      total_GST +=  cost[:GST]
      total_PST +=  cost[:PST]
      total_HST +=  cost[:HST]
      total_cost += cost[:total]
    end
    total_cost += shipping_cost

    @order_totals = {
      subtotal:,
      total_GST:,
      total_PST:,
      total_HST:,
      shipping_cost:,
      total_cost:
    }
  end

  def past_orders
    @customer = Customer.find(current_customer[:id])
  end

  def purchase_confirmation
    session[:cart] = nil
  end

  private

  def load_cart
    @cart = session[:cart]
  end
end
