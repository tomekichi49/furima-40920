FactoryBot.define do
  factory :purchase_form do
    user_id { 1 }
    item_id { 1 }
    postal_code { '123-4567' }
    prefecture_id { 2 } # 1は除外するため
    city { '渋谷区' }
    addresses { '神南1-1' }
    building { 'ロアビル5F' }
    phone_number { '09012345678' }
  end
end