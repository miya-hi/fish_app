class Fish < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :line, presence: true, length: {is: 1}
  validates :n3_oil, presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :vitamin_a, presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :mercury, numericality: { greater_than_or_equal_to: 0, allow_blank: true}
  has_many :diaries, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
