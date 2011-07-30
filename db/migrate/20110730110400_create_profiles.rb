class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, :null => false
      t.string :name, :null => false
      t.string :username, :null => false
      t.text   :bio
      t.string :website
      t.string :twitter
      t.timestamps
    end
  end
end
