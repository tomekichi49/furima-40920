class PurchaseForm
  include ActiveModel::Model

  # 購入情報用の属性
  attr_accessor :user_id, :item_id

  # 発送先情報用の属性
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

  # バリデーションの定義
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンを含めて入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の半角数字で入力してください' }
  end
  
end