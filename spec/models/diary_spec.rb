require 'rails_helper'

RSpec.describe Diary, type: :model do
  before do
    user = FactoryBot.create(:user)
    fish = FactoryBot.create(:fish)
    @diary = FactoryBot.create(:diary, user_id: user.id, fish_id: fish.id)
  end
  describe 'diary作成時のバリデーションテスト' do
    context '全てのカラムに値が入っているとき' do
      it 'diaryを作成できる' do
        expect(@diary).to be_valid
      end
    end
    context '作成日時が空の場合' do
      it 'バリデーションエラーになる' do
        @diary.input_at = ''
        expect(@diary).not_to be_valid
      end
    end
    context '魚が空の場合' do
      it 'バリデーションエラーになる' do
        @diary.fish_id = ''
        expect(@diary).not_to be_valid
      end
    end
    context '量が空の場合' do
      it 'バリデーションエラーになる' do
        @diary.fish_id = ''
        expect(@diary).not_to be_valid
      end
    end
  end
end
