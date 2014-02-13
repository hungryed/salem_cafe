class RemoveFoodIdFromOrders < ActiveRecord::Migration
  def up
    Order.all.each do |order|
      mulitple_foods = OrderFood.new
      mulitple_foods.food_id = order.food_id
      mulitple_foods.order = order
      mulitple_foods.save
    end
    remove_column :orders, :food_id
  end

  def down
    add_column :orders, :food_id, :integer
    Order.all.each do |order|
      order.update_attribute(:food_id,
       OrderFood.where("order_id = ?", order.id).pluck(:food_id).uniq.first)
    end
  end
end
