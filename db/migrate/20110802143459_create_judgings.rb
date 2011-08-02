class CreateJudgings < ActiveRecord::Migration
  def change
    create_table :judgings do |t|
      t.references :user, :null => false
      t.references :challenge, :null => false
      t.references :attempt, :null => false
      t.integer :score
      t.text :comment
      t.timestamps
    end
  end
end
