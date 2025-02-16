class User < ApplicationRecord
  has_many :interests
  has_many :skills

  validates :email, presence: true, uniqueness: true
  validates :age, numericality: { greater_than: 0, less_than_or_equal_to: 90 }
  validates :gender, inclusion: { in: %w[male female] }
end
