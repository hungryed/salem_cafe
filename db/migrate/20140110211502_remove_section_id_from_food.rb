class RemoveSectionIdFromFood < ActiveRecord::Migration
  def up
    remove_column :foods, :section_id
  end

  def down
    add_reference :foods, :section
  end
end
