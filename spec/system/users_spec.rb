require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'User CRUD' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの新規作成が成功' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            fill_in 'user[email]', with: 'test2@example.com'
            fill_in 'user[password]', with: 'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button '新しいアカウントを作成'
            expect(current_path).to eq root_path
            expect(page).to have_content 'アカウント登録が完了しました。'
          end
        end

        context 'メールアドレス未記入' do
          it 'ユーザーの新規作成が失敗' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            # Emailテキストフィールドをnil状態にする
            fill_in 'user[email]', with: nil
            fill_in 'user[password]', with: 'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button '新しいアカウントを作成'
            expect(current_path).to eq user_registration_path
            expect(page).to have_content "メールアドレスを入力してください"
          end
        end

        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗する' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            # Emailテキストフィールドにlet(:user)に定義したユーザーデータのemailを入力
            fill_in 'user[email]', with: user.email
            fill_in 'user[password]', with: 'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button '新しいアカウントを作成'
            expect(current_path).to eq user_registration_path
            expect(page).to have_content "メールアドレスはすでに存在します"
          end
        end
      end
    end

    describe 'ログイン後' do
      before do
        sign_in user
      end

      describe 'ユーザー編集' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの編集が成功' do
            # ユーザー編集画面へ遷移
            visit profile_users_path
            attach_file 'user[profile_image]', "app/assets/images/log.jpeg"
            fill_in 'user[username]', with: 'testuser'
            click_button '更新'
            expect(current_path).to eq root_path
          end
        end

        context 'ユーザー名11文字以上で登録' do
          it 'ユーザーの編集が失敗' do
            # ユーザー編集画面へ遷移
            visit profile_users_path
            attach_file 'user[profile_image]', "app/assets/images/log.jpeg"
            fill_in 'user[username]', with: 'testusertest'
            click_button '更新'
            expect(current_path).to eq user_path(user)
            expect(page).to have_content "ユーザー名は10文字以内で設定してください"
          end
        end
      end
    end
  end
end
