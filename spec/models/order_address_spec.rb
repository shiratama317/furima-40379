require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    order = FactoryBot.create(:order)
    @order_address = FactoryBot.build(:order_address, user_id: order.user_id, item_id: order.item_id)
  end

  describe '商品購入情報の保存' do
    context '購入情報が保存できる場合' do
      it '必要な情報がすべて正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
      it '建物名は空でも保存できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end
    context '購入情報が保存できない場合' do
      it '郵便番号が空では保存できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号にハイフンが含まれていない場合保存できない' do
        @order_address.post_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code は3桁ハイフン4桁の半角数字で登録してください")
      end
      it '郵便番号が全角数値では保存できない' do
        @order_address.post_code = '１２３－４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code は3桁ハイフン4桁の半角数字で登録してください")
      end
      it '郵便番号が数値以外では保存できない' do
        @order_address.post_code = 'aaaaaaa'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code は3桁ハイフン4桁の半角数字で登録してください")
      end
      it '郵便番号が3桁ハイフン4桁以外では保存できない' do
        @order_address.post_code = '1234-567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code は3桁ハイフン4桁の半角数字で登録してください")
      end
      it '都道府県が初期値では保存できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空では保存できない' do
        @order_address.municipalities = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipalities can't be blank")
      end
      it '番地が空では保存できない' do
        @order_address.block_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block number can't be blank")
      end
      it '電話番号が空では保存できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が全角数値では保存できない' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁または11桁の半角数字で登録してください")
      end
      it '電話番号が数値以外では保存できない' do
        @order_address.phone_number = 'あああああ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁または11桁の半角数字で登録してください")
      end
      it '電話番号が9桁以下では保存できない' do
        @order_address.phone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁または11桁の半角数字で登録してください")
      end
      it '電話番号が12桁以上では保存できない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁または11桁の半角数字で登録してください")
      end
      it '電話番号がハイフンを含んでいる場合は保存できない' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁または11桁の半角数字で登録してください")
      end
      it 'tokenが空では保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'itemが紐づいていない場合は保存できない' do
        @order_address.item_id = nil
        sleep 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'userが紐づいていない場合は保存できない' do
        @order_address.user_id = nil
        sleep 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end