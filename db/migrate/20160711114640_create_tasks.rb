class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :description
      t.integer :user_id
      t.integer :state, null: false, default: 0
      t.timestamps null: false
    end
    add_index :tasks, :user_id
  end
end
