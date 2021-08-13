class Diary < ApplicationRecord
  validates :amount, presence: true
  belongs_to :user
  belongs_to :fish

  def self.default_timezone
    :utc
  end

  def fish_n3_oil
    amount * fish.n3_oil/100
  end

  def fish_mercury
    amount * fish.mercury.to_f/100
  end

  def fish_vitamin_a
    amount * fish.vitamin_a/100
  end

  def start_time
    input_at
  end

  def end_time
    input_at.end_of_day
  end
end
