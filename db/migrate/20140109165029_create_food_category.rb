class CreateFoodCategory < ActiveRecord::Migration
  def change
    create_table :food_categories do |t|
      t.references :section, null: false
      t.string :name, null: false
      t.string :description

      t.timestamps
    end
  end
end
