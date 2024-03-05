class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.decimal :GST, precision: 6, scale: 4
      t.decimal :PST, precision: 6, scale: 4
      t.decimal :HST, precision: 6, scale: 4

      t.timestamps
    end
  end
end
