require 'byebug'

class Question < ActiveRecord::Base
  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to :poll,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: :Poll

  has_many :answer_choices,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: :AnswerChoice

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    results = {}
    # answer_choices = self.answer_choices.includes(:responses)
    # answer_choices.each do |answer_choice|
    #   results[answer_choice.text] = answer_choice.responses.length
    # end
    # <<-SQL, self.id
    # SELECT
    #   answer_choices.*, COUNT(responses.id)
    # FROM
    #   answer_choices LEFT JOIN responses
    #   ON answer_choices.id = responses.answer_choice_id
    # WHERE
    #   answer_choices.question_id = ?
    # GROUP BY
    #   answer_choices.id
    # SQL

    answer_choices_with_response_counts = self
      .answer_choices
      .select("answer_choices.text, COUNT(responses.id) AS response_counts")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .group("answer_choices.id")
      debugger
    answer_choices_with_response_counts.each do |answer_choice|
      results[answer_choice.text] = answer_choice.response_counts
    end

    results
  end

end
