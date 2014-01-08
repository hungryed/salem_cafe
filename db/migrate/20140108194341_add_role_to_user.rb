class AddRoleToUser < ActiveRecord::Migration
  def up
    add_column :users, :role, :string, default: 'customer'
    User.all.each do |user|
      user.role = 'customer' if user.role.nil?
      user.save
    end
  end

  def down
    remove_column :users, :role
  end
end
