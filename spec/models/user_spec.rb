require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  before do
    @purchase = FactoryBot.create(:purchase)
    @shipping_address = FactoryBot.build(:shipping_address, purchase: @purchase)
  end

  describe 'バリデーション' do
    it '正しい属性である場合、有効であること' do
      expect(@shipping_address).to be_valid
    end

    it '郵便番号が未入力の場合、無効であること' do
      @shipping_address.postal_code = nil
      @shipping_address.valid?
      expect(@shipping_address.errors[:postal_code]).to include("can't be blank")
    end

    it '不正な郵便番号フォーマットの場合、無効であること' do
      invalid_postal_codes = %w[1234567 12-3456 123-45678]
      invalid_postal_codes.each do |postal_code|
        @shipping_address.postal_code = postal_code
        @shipping_address.valid?
        expect(@shipping_address.errors[:postal_code]).to include('is invalid')
      end
    end

    it '都道府県が未選択の場合、無効であること' do
      @shipping_address.prefecture_id = nil
      @shipping_address.valid?
      expect(@shipping_address.errors[:prefecture_id]).to include("can't be blank")
    end

    it '市区町村が未入力の場合、無効であること' do
      @shipping_address.city = nil
      @shipping_address.valid?
      expect(@shipping_address.errors[:city]).to include("can't be blank")
    end

    it '番地が未入力の場合、無効であること' do
      @shipping_address.addresses = nil
      @shipping_address.valid?
      expect(@shipping_address.errors[:addresses]).to include("can't be blank")
    end

    it '建物名が未入力でも有効であること' do
      @shipping_address.building = nil
      expect(@shipping_address).to be_valid
    end

    it '電話番号が未入力の場合、無効であること' do
      @shipping_address.phone_number = nil
      @shipping_address.valid?
      expect(@shipping_address.errors[:phone_number]).to include("can't be blank")
    end

    it '不正な電話番号フォーマットの場合、無効であること' do
      invalid_phone_numbers = %w[090-1234-5678 090123456789]
      invalid_phone_numbers.each do |phone_number|
        @shipping_address.phone_number = phone_number
        @shipping_address.valid?
        expect(@shipping_address.errors[:phone_number]).to include('is invalid')
      end
    end
  end
end
