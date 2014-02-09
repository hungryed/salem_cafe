class AddSectionToFood < ActiveRecord::Migration
  def up
    add_reference :foods, :section
    Food.all.each do |food|
      food.section = food.food_category.section
      food.save
    end
  end

  def down
    remove_column :foods, :section_id
  end
end
