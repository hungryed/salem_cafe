class AddPriceToFood < ActiveRecord::Migration
  def up
    add_column :foods, :price, :decimal, default: 0
  end

  def down
    remove_column :foods, :price
  end
end
