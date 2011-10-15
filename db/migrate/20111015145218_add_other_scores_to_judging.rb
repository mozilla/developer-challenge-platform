class AddOtherScoresToJudging < ActiveRecord::Migration
  def change
    add_column :judgings, :score2, :integer
    add_column :judgings, :score3, :integer
    add_column :judgings, :score4, :integer
  end
end
