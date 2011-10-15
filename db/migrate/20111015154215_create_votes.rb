class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :attempt, :null => false
      t.references :user, :null => false
      t.timestamps
    end
    
    add_column :attempts, :votes_count, :integer, :default => 0
  end
end
