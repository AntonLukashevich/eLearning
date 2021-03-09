class RadioQuestion < Question
  belongs_to :testing
  has_many :answers, foreign_key: :question_id

  accepts_nested_attributes_for :answers, allow_destroy: true

end