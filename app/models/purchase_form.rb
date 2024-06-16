class PurchaseForm
  include ActiveModel::Model

  # 購入情報用の属性
  attr_accessor :user_id, :item_id

  # 発送先情報用の属性
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

end