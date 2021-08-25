require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  describe 'ユーザー作成時のバリデーションテスト' do
    context '名前、パスワードが正しい場合' do
      it 'ユーザーを作成できる' do
        expect(@user).to be_valid
      end
    end
    context 'ニックネームが空の場合' do
      it 'バリデーションエラーになる' do
        @user.name = nil
        expect(@user).not_to be_valid
      end
    end
    context 'ニックネームが5文字未満の場合' do
      it 'バリデーションエラーになる' do
        @user.name = 'abcd'
        expect(@user).not_to be_valid
      end
    end
    context 'ニックネームが21文字以上の場合' do
      it 'バリデーションエラーになる' do
        @user.name = 'a'*21
        expect(@user).not_to be_valid
      end
    end
    context 'パスワードが空の場合' do
      it 'バリデーションエラーになる' do
        @user.password = ''
        expect(@user).not_to be_valid
      end
    end
    context '出産予定日が280日以降の場合' do
      it 'バリデーションエラーになる' do
        @user.baby_due_on = Date.today+280
        expect(@user).not_to be_valid
      end
    end
    context 'ニックネームが重複した場合' do
      it 'バリデーションエラーになる' do
        user = User.create(
          name: "name001",
          password: "password",
          admin: false,
          baby_due_on: "2021-12-01"
        )
        expect(user).not_to be_valid
      end
    end
  end
end
