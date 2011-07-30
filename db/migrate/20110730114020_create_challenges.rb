class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.references :user, :null => false
      t.references :level, :null => false
      t.references :category, :null => false
      t.references :platform, :null => false
      
      t.string :source, :null => false
      t.string :state, :null => false
      t.string :title, :null => false
      t.text   :abstract, :null => false
      t.text   :resources
      
      t.datetime :starts_at, :null => false
      t.datetime :ends_at, :null => false
      t.timestamps
    end
    add_index :challenges, :source
  end
end
