class Fish < ApplicationRecord
  validates :name, presence: true
  validates :line, presence: true
  validates :n3_oil, presence: true
  validates :vitamin_a, presence: true
  has_many :diaries, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
