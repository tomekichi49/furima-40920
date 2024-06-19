require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_form = FactoryBot.build(:purchase_form, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    
    context '商品購入がうまくいくとき' do
      it '全ての項目が存在すれば登録できる' do
          expect(@purchase_form).to be_valid
      end

      it '建物名が空でも登録できる' do
          @purchase_form.building = ''
          expect(@purchase_form).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it 'トークンが空では登録できない' do
        @purchase_form.token = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空では登録できない' do
          @purchase_form.postal_code = ''
          @purchase_form.valid?
          expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンがないと登録できない' do
          @purchase_form.postal_code = '1234567'
          @purchase_form.valid?
          expect(@purchase_form.errors.full_messages).to include('Postal code input correctly')
      end

      it '都道府県が未選択では登録できない' do
          @purchase_form.prefecture_id = 1
          @purchase_form.valid?
          expect(@purchase_form.errors.full_messages).to include("Prefecture select")
      end

      it '市区町村が空では登録できない' do
          @purchase_form.city = ''
          @purchase_form.valid?
          expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では登録できない' do
          @purchase_form.addresses = ''
          @purchase_form.valid?
          expect(@purchase_form.errors.full_messages).to include("Addresses can't be blank")
      end

      it '電話番号が空では登録できない' do
          @purchase_form.phone_number = ''
          @purchase_form.valid?
          expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が全角数字だと登録できない' do
          @purchase_form.phone_number = '０９０１２３４５６７８'
          @purchase_form.valid?
          expect(@purchase_form.errors.full_messages).to include('Phone number input only number')
      end

      it '電話番号が12桁以上だと登録できない' do
          @purchase_form.phone_number = '090123456789'
          @purchase_form.valid?
          expect(@purchase_form.errors.full_messages).to include('Phone number input only number')
      end
      it '電話番号が9桁以下では登録できない' do
        @purchase_form.phone_number = '090123456'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number input only number')
      end

      it 'userが紐付いていなければ購入できない' do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていなければ購入できない' do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
      end
      
    end
  end
end