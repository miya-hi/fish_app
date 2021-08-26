class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: {minimum:5, maximum: 20}
  # validates :password, presence: true, length: {minimum:6}
  validate :pregnancy
  validate :due_not_past
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

  def pregnancy
    if baby_due_on && baby_due_on >= Date.today.since(280.days)
      errors.add(:baby_due_on, "は280日以降の登録ができません")
    end
  end

  def due_not_past
    return false unless new_record?
    if baby_due_on && baby_due_on < Date.today
      errors.add(:baby_due_on, "は過去の日付が登録できません")
    end
  end
end
