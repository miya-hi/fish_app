require 'rails_helper'

RSpec.describe 'Fishes', type: :system do
  describe '魚のお気に入り登録機能' do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:fish)
      visit new_user_session_path
      fill_in 'user[name]', with: 'name001'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
    end
    context 'お気に入り追加にチェックした場合' do
      it '魚がお気に入り一覧に追加される' do
        find('.mybutton').click
        select 'あ', from: 'diary[line]'
        sleep 0.5
        select 'fish001', from: 'diary[fish_id]'
        check 'register_favorite'
        fill_in 'diary[amount]', with: '80'
        click_button '登録'
        find('.mybutton').click
        expect(page).to have_select('favorite[fish_id]', options: ['選択して下さい', 'fish001'])
      end
    end
    context 'お気に入りを削除した場合' do
      it 'お気に入り一覧から魚が削除される' do
        find('.mybutton').click
        select 'あ', from: 'diary[line]'
        sleep 0.5
        select 'fish001', from: 'diary[fish_id]'
        check 'register_favorite'
        fill_in 'diary[amount]', with: '80'
        click_button '登録'
        find('.mybutton').click
        expect(page).to have_select('favorite[fish_id]', options: ['選択して下さい', 'fish001'])

        #削除
        click_link 'お気に入り削除'
        switch_to_window(windows.last)
        expect(current_path).to eq favorites_path
        click_button '削除'
        expect(current_path).to eq favorites_path
        expect(page).to have_content 'fish001のお気に入りを削除しました'

        #お気に入りが削除されているか確認
        visit new_diary_path
        expect(page).not_to have_select('favorite[fish_id]', options: ['選択して下さい', 'fish001'])
      end
    end
  end
end
