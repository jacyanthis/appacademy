class AddTextColumn < ActiveRecord::Migration
  def change
    add_column :answer_choices, :text, :text
    change_column :answer_choices, :text, :text, null: false
  end
end
