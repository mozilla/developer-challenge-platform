class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.references :challenge, :null => false
      t.references :user, :null => false
      t.references :language, :null => false
      t.string :repository_url
      t.text   :description, :null => false
      t.timestamps
    end
  end
end
