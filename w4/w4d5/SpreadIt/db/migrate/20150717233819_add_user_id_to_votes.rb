class AddUserIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :user_id, :integer
    change_column :votes, :user_id, :integer, null: false
    add_index :votes, :user_id
  end
end
