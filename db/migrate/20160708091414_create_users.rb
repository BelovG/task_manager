class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :remember_token
      t.integer :role, null: false, default: 0
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :remember_token
  end
end
