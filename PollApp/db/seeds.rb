# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(user_name: 'Yi-Ke')
User.create!(user_name: 'Kia')

Poll.create!(title: 'Abortion', author_id: 1)
Poll.create!(title: 'Immigration', author_id: 2)

Question.create!(text: 'Is abortion immoral?', poll_id: 1)
Question.create!(text: 'Should we build a fence?', poll_id: 2)

AnswerChoice.create!(text:'Yes', question_id: 1)
AnswerChoice.create!(text:'No', question_id: 1)
AnswerChoice.create!(text:'Yes', question_id: 2)
AnswerChoice.create!(text:'No', question_id: 2)

Response.create!(answer_choice_id: 2, user_id: 2)
Response.create!(answer_choice_id: 4, user_id: 1)
