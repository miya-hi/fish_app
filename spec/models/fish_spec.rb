require 'rails_helper'

RSpec.describe Fish, type: :model do
  before do
    @fish = FactoryBot.create(:fish)
  end
  describe '魚作成時のバリデーションテスト' do
    context '全てのカラムに値が入っているとき' do
      it '魚を作成できる' do
        expect(@fish).to be_valid
      end
    end
    context 'content、image、水銀カラムが空の場合' do
      it '魚を作成できる' do
        fish = Fish.create(
          name: 'fish004',
          line: 'た',
          n3_oil: '1.30',
          vitamin_a: '300',
          mercury: nil,
          content: '',
          image: ''
        )
        expect(fish).to be_valid
      end
    end
    context '名前が重複する場合' do
      it 'バリデーションエラーになる' do
        fish2 = Fish.create(
          name: 'fish001',
          line: 'な',
          n3_oil: '1.10',
          vitamin_a: '400',
          mercury: nil,
          content: '',
          image: ''
        )
        expect(fish2).not_to be_valid
      end
    end
    context '名前が空の場合' do
      it 'バリデーションエラーになる' do
        @fish.name = ''
        expect(@fish).not_to be_valid
      end
    end
    context '行が空の場合' do
      it 'バリデーションエラーになる' do
        @fish.line = ''
        expect(@fish).not_to be_valid
      end
    end
    context '行が2文字以上の場合' do
      it 'バリデーションエラーになる' do
        @fish.line = 'ああ'
        expect(@fish).not_to be_valid
      end
    end
    context 'n-3系脂肪酸が空の場合' do
      it 'バリデーションエラーになる' do
        @fish.n3_oil = ''
        expect(@fish).not_to be_valid
      end
    end
    context 'n-3系脂肪酸が負の値の場合' do
      it 'バリデーションエラーになる' do
        @fish.n3_oil = '-1.0'
        expect(@fish).not_to be_valid
      end
    end
    context 'ビタミンAが空の場合' do
      it 'バリデーションエラーになる' do
        @fish.vitamin_a = ''
        expect(@fish).not_to be_valid
      end
    end
    context 'ビタミンAが負の値の場合' do
      it 'バリデーションエラーになる' do
        @fish.vitamin_a = '-1'
        expect(@fish).not_to be_valid
      end
    end
    context '水銀が負の値の場合' do
      it 'バリデーションエラーになる' do
        @fish.mercury = '-1.0'
        expect(@fish).not_to be_valid
      end
    end
  end
end
