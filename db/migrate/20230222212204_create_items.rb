class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.float :instant_buy_price
      t.bigint :bought_by

      t.timestamps
    end
  end
end
