require 'rails_helper'

RSpec.describe 'Fishes', type: :system do
  describe '魚の新規登録機能' do
    before do
      FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'user[name]', with: 'name001'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
    end
    context 'ユーザーが管理者権限を持つ場合' do
      it '魚を新規登録できる' do
        click_link '管理者ページ'
        click_button '魚の一覧へ'
        click_link '新規登録へ'

        #新規登録
        expect(page).to have_content '《管理者ページ》新しい魚の登録'
        fill_in 'fish[name]', with: 'fish001'
        fill_in 'fish[line]', with: 'あ'
        fill_in 'fish[n3_oil]', with: '1.5'
        fill_in 'fish[vitamin_a]', with: '500'
        fill_in 'fish[mercury]', with: '62.5'
        fill_in 'fish[content]', with: ''
        click_button '登録する'
        expect(current_path).to eq admin_fishes_path

        #カレンダーに登録して確認
        click_link 'グラフ/カレンダー'
        find('.mybutton').click
        select 'あ', from: 'diary[line]'
        sleep 0.5
        select 'fish001', from: 'diary[fish_id]'
        fill_in 'diary[amount]', with: '100'
        click_button '登録'
        expect(current_path).to eq diaries_path
        expect(page).to have_content 'fish001'

        #詳細ページで数値を確認
        sleep 2
        find('.today > a').click
        sleep 4
        expect(current_path).to eq diary_path(Date.today.strftime("%Y-%m-%d"))
        expect(page).to have_content 'fish001'
        expect(page).to have_content '1.5g'
        expect(page).to have_content '500μgRAE'
        expect(page).to have_content '63%'
      end
    end
  end
  describe '魚の編集機能' do
    before do
      FactoryBot.create(:user)
      @fish = FactoryBot.create(:second_fish)
      visit new_user_session_path
      fill_in 'user[name]', with: 'name001'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
    end
    context 'ユーザーが管理者権限を持つ場合' do
      it '魚を編集できる' do
        click_link '管理者ページ'
        click_button '魚の一覧へ'
        select 'か', from: 'line'
        sleep 0.5
        select 'fish002', from: 'name'
        click_button '選択した魚の編集'
        expect(current_path).to eq edit_admin_fish_path(@fish.id)

        #編集
        fill_in 'fish[name]', with: 'FISH002'
        click_button '更新する'
        expect(current_path).to eq admin_fishes_path
        expect(page).to have_content '魚の情報を更新しました'

        #カレンダーに登録して確認
        click_link 'グラフ/カレンダー'
        find('.mybutton').click
        select 'か', from: 'diary[line]'
        sleep 0.5
        select 'FISH002', from: 'diary[fish_id]'
        fill_in 'diary[amount]', with: '80'
        click_button '登録'
        expect(current_path).to eq diaries_path
        expect(page).to have_content 'FISH002'
        expect(page).not_to have_content 'fish002'
      end
    end
  end
  describe '魚の削除機能' do
    before do
      FactoryBot.create(:user)
      @fish = FactoryBot.create(:third_fish)
      visit new_user_session_path
      fill_in 'user[name]', with: 'name001'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
    end
    context 'ユーザーが管理者権限を持つ場合' do
      it '魚を編集できる' do
        click_link '管理者ページ'
        click_button '魚の一覧へ'
        select 'さ', from: 'line'
        sleep 0.5
        select 'fish003', from: 'name'
        click_button '選択した魚の編集'
        expect(current_path).to eq edit_admin_fish_path(@fish.id)

        #削除
        click_button 'この魚を削除'
        expect(current_path).to eq admin_fishes_path
        expect(page).to have_content '魚を削除しました'
      end
    end
  end
end
