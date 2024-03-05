class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.belongs_to :province, optional: true

      t.string :first_name
      t.string :last_name
      t.string :apartment
      t.string :street_number
      t.string :street_name
      t.string :city
      t.string :postal_code
      t.string :phone

      t.timestamps
    end
  end
end
