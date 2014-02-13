class CreateOrderFoods < ActiveRecord::Migration
  def change
    create_table :order_foods do |t|
      t.references :food, null: false
      t.references :order, null: false

      t.timestamps
    end
  end
end
