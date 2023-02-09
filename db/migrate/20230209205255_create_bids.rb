class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.belongs_to :user, null: false
      t.float :amount, default: 0

      t.timestamps
    end
  end
end
