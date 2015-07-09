class CreateTagtopics < ActiveRecord::Migration
  def change
    create_table :tagtopics do |t|
      t.string :topic
      t.timestamps
    end

    add_index :tagtopics, :topic
  end
end
