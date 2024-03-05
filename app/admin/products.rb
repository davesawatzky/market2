ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :brand, :inventory, :floor_date, :SKU, :price, :on_sale, :taxable_GST, :taxable_PST, :taxable_HST, :details, :category, :image_url, :image

  # Done by Formtastic Gem
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.inputs do
      f.input :image, as: :file
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :type, :inventory, :floor_date, :SKU, :price, :taxable_GST, :taxable_PST, :details]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
