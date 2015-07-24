class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :description, null: false
      t.boolean :is_private, default: true
      t.boolean :is_completed, default: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
    add_index :goals, :is_private
  end
end
