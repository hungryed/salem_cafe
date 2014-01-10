class AddFoodCategoryToFood < ActiveRecord::Migration
  def up
    add_reference :foods, :food_category
  end

  def down
    remove_column :foods, :food_category_id
  end
end
