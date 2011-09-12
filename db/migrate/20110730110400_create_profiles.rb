class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, :null => false
      t.string :name, :null => false
      t.string :username, :null => false
      t.text   :bio
      t.string :website
      t.string :twitter
      
      # GitHub Fields
      t.string  :github_token
      t.string  :github_username
      t.string  :github_url
      t.integer :github_public_repo_count
      t.integer :github_followers_count
      
      # Twitter Fields
      t.string  :twitter_token
      t.string  :twitter_secret
      t.string  :twitter_username
      
      t.timestamps
    end
    add_index :profiles, :username
  end
end
