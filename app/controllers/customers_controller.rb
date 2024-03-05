class CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer[:id])
  end

  def sign_in
    @render_cart = false
  end

  def sign_up
    @render_cart = false
  end

  def update
    customer = params[:customer]
    Rails.logger.debug "customer update: #{customer}"
    Customer.update(
      first_name:    customer[:first_name],
      last_name:     customer[:last_name],
      apartment:     customer[:apartment],
      street_number: customer[:street_number],
      street_name:   customer[:street_name],
      city:          customer[:city],
      postal_code:   customer[:postal_code],
      province_id:   customer[:province_id],
      phone:         customer[:phone],
      email:         customer[:email]
    )
    redirect_to root_path
  end
end
