class AddReceiveTextDecisionToUser < ActiveRecord::Migration
  def up
    add_column :users, :receives_texts, :boolean, default: false
  end

  def down
    remove_column :users, :receives_texts
  end
end
