class AddOnMenuToFood < ActiveRecord::Migration
  def up
    add_column :foods, :on_menu, :boolean, default: false
  end

  def down
    remove_column :foods, :on_menu
  end
end
