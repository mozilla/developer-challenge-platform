class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :auth_token, :null => false
      t.string :password_digest
      t.boolean :admin, :default => false, :null => false
      t.boolean :judge, :default => false, :null => false
      t.boolean :reviewer, :default => false, :null => false
      t.timestamps
    end
    add_index :users, :email, :unique => true
    add_index :users, :auth_token, :unique => true
  end
end
