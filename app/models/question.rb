class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  scope :latest ,->{order('updated_at desc')}

  def self.search(search)
    if search
      Question.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
    else
      Question.all
    end
  end

end
