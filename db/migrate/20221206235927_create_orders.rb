class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.belongs_to :customer, index: true, foreign_key: true

      t.date :date_submitted
      t.date :date_delivered
      t.decimal :subtotal, precision: 10, scale: 2
      t.decimal :shipping_cost, precision: 10, scale: 2
      t.decimal :totalGST, precision: 10, scale: 2
      t.decimal :totalPST, precision: 10, scale: 2
      t.decimal :totalHST, precision: 10, scale: 2
      t.decimal :total_cost, precision: 10, scale: 2
      t.boolean :paid
      t.string :transaction_number
      t.boolean :delivered

      t.timestamps
    end
  end
end
