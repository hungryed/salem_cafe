class AddMultipleOptionToFoodCategory < ActiveRecord::Migration
  def up
    add_column :food_categories, :multiple, :boolean, default: false
    FoodCategory.all.each do |category|
      category.multiple = false
      category.save
    end
    change_column :food_categories, :multiple, :boolean, null: false
  end

  def down
    remove_column :food_categories, :multiple
  end
end
