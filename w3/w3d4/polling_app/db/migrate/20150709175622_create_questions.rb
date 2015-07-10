class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text, null: false
      t.integer :poll_id
      t.timestamps null: false
    end

    add_index :questions, :poll_id
  end
end
