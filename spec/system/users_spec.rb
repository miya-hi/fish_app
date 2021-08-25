require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ユーザーの新規登録機能' do
    before do
      FactoryBot.create(:user)
      visit new_user_registration_path
    end
    context 'ニックネームとパスワードが正しい場合' do
      it '新規登録ができる' do
        fill_in 'user[name]', with: 'さかな子001'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録'
        expect(page).to have_content 'アカウントが登録されました'
        expect(page).to have_content 'さかな子001さん'
      end
    end
    context 'ニックネームが未記入の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: ''
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録'
        expect(page).to have_content 'ニックネームを入力してください'
        expect(page).to have_content 'ニックネームは5文字以上で入力してください'
      end
    end
    context 'ニックネームが5文字未満の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: 'さかな子'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録'
        expect(page).to have_content 'ニックネームは5文字以上で入力してください'
      end
    end
    context 'ニックネームが21文字以上の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: 'a'*21
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録'
        expect(page).to have_content 'ニックネームは20文字以内で入力してください'
      end
    end
    context 'ニックネームが重複する場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: 'name001'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録'
        expect(page).to have_content 'ニックネームは既に存在します'
      end
    end
    context 'パスワードが未入力の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: 'さかな子001'
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '登録'
        expect(page).to have_content 'ユーザー登録'
        expect(page).to have_content 'パスワードを入力してください'
      end
    end
    context 'パスワードが6文字未満の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: 'さかな子001'
        fill_in 'user[password]', with: 'passw'
        fill_in 'user[password_confirmation]', with: 'passw'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録'
        expect(page).to have_content 'パスワードは6文字以上で入力してください'
      end
    end
    context 'パスワードが一致しない場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: 'さかな子001'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'passward'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録'
        expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
      end
    end
    context '出産予定日が280日以降の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: 'さかな子001'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        select '2022', from: 'user[baby_due_on(1i)]'
        select '12', from: 'user[baby_due_on(2i)]'
        select '31', from: 'user[baby_due_on(3i)]'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録'
        expect(page).to have_content '出産予定日は280日以降の登録ができません'
      end
    end
  end
  describe 'ユーザーのログイン機能' do
    before do
      FactoryBot.create(:user)
      visit new_user_session_path
    end
    context 'ニックネームとパスワードが正しい場合' do
      it 'ログインができる' do
        fill_in 'user[name]', with: 'name001'
        fill_in 'user[password]', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content 'name001さん'
      end
    end
    context 'ニックネームが未記入の場合' do
      it 'ログインに失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[password]', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'ニックネームまたはパスワードが無効です'
      end
    end
    context 'パスワードが未記入の場合' do
      it 'ログインに失敗する' do
        fill_in 'user[name]', with: 'name001'
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'ニックネームまたはパスワードが無効です'
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'ログアウトができる' do
        fill_in 'user[name]', with: 'name001'
        fill_in 'user[password]', with: 'password'
        click_button 'ログイン'
        click_link 'ログアウト'
        expect(page).to have_content 'おさかなモニターとは'
        expect(page).to have_content 'ログアウトしました'
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'ログアウトができる' do
        fill_in 'user[name]', with: 'name001'
        fill_in 'user[password]', with: 'password'
        click_button 'ログイン'
        click_link 'ログアウト'
        expect(page).to have_content 'おさかなモニターとは'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe 'ユーザー情報の編集・削除機能' do
    before do
      FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'user[name]', with: 'name001'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
    end
    context 'ユーザー編集画面に移動した場合' do
      it 'ユーザー情報の編集ができる' do
        click_link 'name001さん'
        click_button '編集する'
        fill_in 'user[name]', with: 'name004'
        fill_in 'user[current_password]', with: 'password'
        click_button '更新'
        expect(page).to have_content 'name004さん'
        expect(page).to have_content 'アカウント情報が更新されました'
      end
      it 'ユーザー情報の削除ができる' do
        click_link 'name001さん'
        click_button 'やめる'
        page.accept_confirm
        expect(page).to have_content 'おさかなモニターとは'
        expect(page).to have_content 'ありがとうございました。またご利用下さい。'
      end
    end
  end
  describe '管理者機能' do
    before do
      FactoryBot.create(:third_user)
      FactoryBot.create(:second_user)
      visit new_user_session_path
      fill_in 'user[name]', with: 'name002'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
    end
    context 'ユーザーが管理者機能を持つ場合' do
      it '他ユーザーに管理者権限を付与できる' do
        click_link '管理者ページ'
        click_button '管理者権限の変更', match: :first
        check 'user[admin]'
        click_button '変更する'
        expect(page).to have_content '○'
        expect(page).to have_content '管理者権限を更新しました'
      end
      it '自分の管理者権限の削除ができる' do
        click_link '管理者ページ'
        within('.wrapper > table > tbody > tr:nth-last-of-type(1)') do
          click_button '管理者権限の変更'
        end
        uncheck 'user[admin]'
        click_button '変更する'
        expect(page).to have_content 'アクセス権限がありません'
      end
    end
  end
  describe 'ゲストログイン機能' do
    before do
      visit root_path
    end
    context 'ゲストログインボタンを押した場合' do
      it 'ゲストログインができる' do
        click_link 'ゲストログイン'
        expect(page).to have_content 'ゲスト001さん'
        expect(page).to have_content 'ゲストユーザーとしてログインしました'

        click_link 'ログアウト'
        expect(page).to have_content 'おさかなモニターとは'
        expect(page).to have_content 'ログアウトしました'
      end
    end
    context '管理者ゲストログインボタンを押した場合' do
      it '管理者ゲストログインができる' do
        click_link '管理者ゲストログイン'
        expect(page).to have_content '管理者001さん'
        expect(page).to have_content 'ゲスト管理者としてログインしました'

        click_link 'ログアウト'
        expect(page).to have_content 'おさかなモニターとは'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end
