class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :food, null: false
      t.references :user, null: false
      t.datetime :arrival_time, null: false

      t.timestamps
    end
  end
end
