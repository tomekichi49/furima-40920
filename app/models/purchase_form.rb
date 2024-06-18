class PurchaseForm
  include ActiveModel::Model

  # 購入情報用の属性
  attr_accessor :user_id, :item_id

  # 発送先情報用の属性
  attr_accessor :token, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

  # バリデーションの定義
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "input correctly" }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'input only number' }
  end

    validates :prefecture_id, numericality: { other_than: 1, message: "select" }

  def save
    return false unless valid?

    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(
      purchase_id: purchase.id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number
    )
  end
end