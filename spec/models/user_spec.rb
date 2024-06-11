require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = 'a12345'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

      it 'nicknameが7文字以上では登録できない' do
        @user.nickname = 'a' * 7
        @user.valid?
        expect(@user.errors.full_messages).to include 'Nickname is too long (maximum is 6 characters)'
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = 'a' * 129
        @user.password_confirmation = 'a' * 129
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too long (maximum is 128 characters)'
      end

      it 'パスワードは単なる数字のみで構成されている場合' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password は半角英数字混合で入力してください'
      end

      it 'パスワードは単なる小文字のみで構成されている場合' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password は半角英数字混合で入力してください'
      end

      it 'パスワードに全角文字が含まれている場合' do
        @user.password = 'a１２３４５６'
        @user.password_confirmation = 'a１２３４５６'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password は半角英数字混合で入力してください'
      end

      it 'お名前(全角)は、名字が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end

      it 'お名前(全角)は、名前が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end

      it 'お名前(全角)は、名字が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name は全角（漢字・ひらがな・カタカナ）で入力してください'
      end

      it 'お名前(全角)は、名前が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'John'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name は全角（漢字・ひらがな・カタカナ）で入力してください'
      end

      it 'お名前カナ(全角)は、名字が必須であること' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end

      it 'お名前カナ(全角)は、名前が必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end

      it 'お名前カナ(全角)は、名字が全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'すみす'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name kana は全角カタカナで入力してください'
      end

      it 'お名前カナ(全角)は、名前が全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kana は全角カタカナで入力してください'
      end

      it '生年月日が必須であること' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end

      it 'メールアドレスが一文字の場合（\'a\'など）' do
        @user.email = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
    end
  end
end
