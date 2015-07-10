class AddQuestionId < ActiveRecord::Migration
  def change
    add_column :answer_choices, :question_id, :integer
    change_column :answer_choices, :question_id, :integer, null: false
  end
end
