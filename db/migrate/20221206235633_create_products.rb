class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.belongs_to :category, index: true, foreign_key: true

      t.string :name
      t.string :brand
      t.integer :inventory
      t.date :floor_date
      t.string :SKU
      t.decimal :price, precision: 10, scale: 2
      t.boolean :on_sale
      t.boolean :taxable_GST
      t.boolean :taxable_PST
      t.boolean :taxable_HST
      t.string :details
      t.string :image_url

      t.timestamps
    end
  end
end
