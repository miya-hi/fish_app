class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: {maximum: 20}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def email_required?
    false
  end
  def email_changed?
    false
  end
end
