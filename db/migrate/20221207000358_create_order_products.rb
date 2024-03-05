class CreateOrderProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :order_products do |t|
      t.belongs_to :order, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key: true

      t.integer :quantity
      t.decimal :price_per_item, precision: 10, scale: 2
      t.decimal :subtotal, precision: 10, scale: 2
      t.decimal :GST, precision: 10, scale: 2
      t.decimal :PST, precision: 10, scale: 2
      t.decimal :HST, precision: 10, scale: 2

      t.timestamps
    end
  end
end
