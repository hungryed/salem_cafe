class AddReferenceToSectionFromOrderAndFood < ActiveRecord::Migration
  def up
    add_reference :orders, :section
    add_reference :foods, :section
  end

  def down
    remove_column :orders, :section_id
    remove_column :foods, :section_id
  end
end
