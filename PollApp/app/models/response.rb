class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_already_answered?
  validate :respondent_poll_author?

  belongs_to :answer_choice,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll

  has_one :author,
    through: :poll,
    source: :author


  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:user_id] << "Respondent has already answered this question."
    end
  end

  def respondent_poll_author?
    # debugger
    if self.author.id == self.user_id
      errors[:user_id] << "Respondent is also the poll's author."
    end
  end
end
