ActiveAdmin.register Customer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :province, :first_name, :last_name, :apartment, :street_number, :street_name, :city, :postal_code, :phone, :email
  #
  # or
  #
  # permit_params do
  #   permitted = [:province_id, :first_name, :last_name, :apartment, :street_number, :street_name, :city, :postal_code, :phone, :distance, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
