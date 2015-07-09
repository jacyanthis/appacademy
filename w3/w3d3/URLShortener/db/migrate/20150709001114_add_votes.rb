class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :url_id
      t.boolean :up
    end
  end
end
