class AddStartsAtAndEndsAtToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :starts_at, :datetime
    add_column :challenges, :ends_at, :datetime
  end
end
