require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができるとき' do
      it '必要な情報が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録ができないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在していては登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@を含んでいないときは登録できない' do
        @user.email = 'testemail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Alphanumeric.alphanumeric(number: 129, min_alpha: 1, min_numeric: 1)
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角で英字と数字の両方を含めて設定してください')
      end
      it 'passwordが半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角で英字と数字の両方を含めて設定してください')
      end
      it 'passwordが全角では登録できない' do
        @user.password = 'ｓｓｓｓｓｓ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角で英字と数字の両方を含めて設定してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'test12'
        @user.password_confirmation = 'test123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_nameが英語では登録できない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角文字を使用してください')
      end
      it 'first_nameが英語では登録できない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角文字を使用してください')
      end
      it 'last_nameが半角カナでは登録できない' do
        @user.last_name = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角文字を使用してください')
      end
      it 'first_nameが半角カナでは登録できない' do
        @user.first_name = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角文字を使用してください')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_name_kanaが半角では登録できない' do
        @user.last_name_kana = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カナを使用してください')
      end
      it 'last_name_kanaがひらがなでは登録できない' do
        @user.last_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カナを使用してください')
      end
      it 'last_name_kanaが漢字では登録できない' do
        @user.last_name_kana = '試験'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カナを使用してください')
      end
      it 'first_name_kanaが半角では登録できない' do
        @user.first_name_kana = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カナを使用してください')
      end
      it 'first_name_kanaがひらがなでは登録できない' do
        @user.first_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カナを使用してください')
      end
      it 'first_name_kanaが漢字では登録できない' do
        @user.first_name_kana = '試験'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カナを使用してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
