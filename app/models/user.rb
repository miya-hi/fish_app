class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: {maximum: 20}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :diaries, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_fishes, through: :favorites, source: :fish

  def email_required?
    false
  end
  def email_changed?
    false
  end
  def self.guest
    find_or_create_by!(name: 'ゲスト001') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.baby_due_on = '2021-12-01'
    end
  end
  def self.admin_guest
    find_or_create_by!(name: '管理者001', admin: true) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.baby_due_on = '2021-12-01'
    end
  end
end
