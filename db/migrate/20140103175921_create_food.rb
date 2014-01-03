class CreateFood < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.string :picture
      t.text :description

      t.timestamps
    end
  end
end
