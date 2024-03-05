ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :customer_id, :date_submitted, :date_delivered, :subtotal, :shipping_cost, :totalGST, :totalPST, :totalHST, :total_cost, :paid, :transaction_number, :delivered
  #
  # or
  #
  # permit_params do
  #   permitted = [:delivery_id, :customer_id, :date_submitted, :date_delivered, :subtotal, :shipping_cost, :totalGST, :totalPST, :total_cost, :paid, :transaction_number, :delivered]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
