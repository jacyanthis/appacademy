# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

bob = User.create!(username: "Bob")
jill = User.create!(username: "Jill")

poll = Poll.create!(title: "Voting Preferences", author: jill)

question = Question.create!(text: "Would you vote for me? :)", poll: poll)

answer_choice_1 = AnswerChoice.create!(text: "Yes", question_id: question.id)

answer_choice_2 = AnswerChoice.create!(text: "No", question: question)

response_1 = Response.create!(answer_choice: answer_choice_1, respondent: jill)

response_2 = Response.create!(answer_choice: answer_choice_2, respondent: bob)
