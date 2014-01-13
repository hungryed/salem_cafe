class AddOperationHoursToSections < ActiveRecord::Migration
  def up
    add_column :sections, :start_time, :time, null: false, default: '0:00'
    add_column :sections, :end_time, :time, null: false, default: '23:00'
  end

  def down
    remove_column :sections, :start_time
    remove_column :sections, :end_time
  end
end
