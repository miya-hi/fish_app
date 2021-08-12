class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :fish

  def self.default_timezone
    :utc
  end

  def start_time
    input_at
  end

  def end_time
    input_at.end_of_day
  end
end
