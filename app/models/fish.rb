class Fish < ApplicationRecord
  has_many :diaries
  has_many :favorites, dependent: :destroy
end
