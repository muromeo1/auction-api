class AddItemToBid < ActiveRecord::Migration[7.0]
  def change
    add_reference :bids, :item, null: false, foreign_key: true
  end
end
