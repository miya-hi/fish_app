require 'rails_helper'

RSpec.describe 'Diaries', type: :system do
  describe '魚の登録機能' do
    before do
      FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'user[name]', with: 'name001'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
    end
    context '魚の新規登録ページに移動した場合' do
      it '魚をカレンダーに登録できる' do
        find('.mybutton').click
        select 'か', from: 'diary[line]'
        sleep 0.5
        select 'カジキ(ﾒｶｼﾞｷ)', from: 'diary[fish_id]'
        fill_in 'diary[amount]', with: '80'
        click_button '登録'
        expect(current_path).to eq diaries_path
        # expect(page).to have_content /\d{1,2}月 \d{4}/
        expect(page).to have_content 'カジキ(ﾒｶｼﾞｷ)'
	# 追加登録
        find('.today > a').click
        find('a > .mybutton-left').click
        select 'さ', from: 'diary[line]'
        sleep 0.5
        select 'さば 缶詰', from: 'diary[fish_id]'
        fill_in 'diary[amount]', with: '100'
        click_button '登録'
        expect(current_path).to eq diaries_path
        expect(page).to have_content 'カジキ(ﾒｶｼﾞｷ)'
        expect(page).to have_content 'さば 缶詰'
      end
    end
  end
  describe '魚の編集機能' do
    before do
      FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'user[name]', with: 'name001'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
      find('.mybutton').click
      select 'か', from: 'diary[line]'
      sleep 0.5
      select 'カジキ(ﾒｶｼﾞｷ)', from: 'diary[fish_id]'
      fill_in 'diary[amount]', with: '80'
      click_button '登録'
    end
    context '登録済みのカレンダーをクリックした場合' do
      it '魚を編集できる' do
        sleep 2
        find('.today > a').click
        sleep 4
        expect(current_path).to eq diary_path(Date.today.strftime("%Y-%m-%d"))
        click_button '編集'
        select 'さ', from: 'diary[line]'
        sleep 0.5
        select 'さば 缶詰', from: 'diary[fish_id]'
        fill_in 'diary[amount]', with: '100'
        click_button '登録'
        expect(current_path).to eq diary_path(Date.today.strftime("%Y-%m-%d"))
        expect(page).not_to have_content 'カジキ(ﾒｶｼﾞｷ)'
        expect(page).to have_content 'さば 缶詰'
      end
    end
  end
  describe '魚の削除機能' do
    before do
      FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'user[name]', with: 'name001'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
      find('.mybutton').click
      select 'か', from: 'diary[line]'
      sleep 0.5
      select 'カジキ(ﾒｶｼﾞｷ)', from: 'diary[fish_id]'
      fill_in 'diary[amount]', with: '80'
      click_button '登録'
      sleep 2
      find('.today > a').click
      expect(current_path).to eq diary_path(Date.today.strftime("%Y-%m-%d"))
    end
    context '削除ボタンをクリックした場合' do
      it '魚を削除できる' do
        click_button '削除'
        accept_confirm
        expect(current_path).to eq diaries_path
        expect(page).to have_content '削除しました'
      end
    end
  end
  describe 'グラフ表示機能' do
    before do
      FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'user[name]', with: 'name001'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
    end
    context '魚の新規登録した場合' do
      it 'グラフに数値とメッセージが表示される' do
        find('.mybutton').click
        select 'か', from: 'diary[line]'
        sleep 0.5
        select 'カジキ(ﾒｶｼﾞｷ)', from: 'diary[fish_id]'
        fill_in 'diary[amount]', with: '80'
        click_button '登録'
        expect(current_path).to eq diaries_path
        expect(page).to have_content '100%'
        expect(page).to have_content '多い魚は控えましょう'
        expect(page).to have_content '0.7g'
        expect(page).to have_content '青魚がおすすめです'
	# 追加登録
        find('.today > a').click
        find('.mybutton-left').click
        select 'さ', from: 'diary[line]'
        sleep 0.5
        select 'さば 缶詰', from: 'diary[fish_id]'
        fill_in 'diary[amount]', with: '200'
        click_button '登録'
        expect(current_path).to eq diaries_path
        expect(page).to have_content '100%'
        expect(page).to have_content '多い魚は控えましょう'
        expect(page).to have_content '6.2g'
        expect(page).to have_content 'あと少し'
      end
    end
  end
end
