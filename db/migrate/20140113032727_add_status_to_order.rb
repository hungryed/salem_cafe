class AddStatusToOrder < ActiveRecord::Migration
  def up
    add_column :orders, :status, :string, null: false, default: 'not started'
  end

  def down
    remove_column :orders, :status
  end
end
