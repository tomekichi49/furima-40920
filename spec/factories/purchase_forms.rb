FactoryBot.define do
  factory :purchase_form do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '渋谷区' }
    addresses { '神南1-1' }
    building { 'ロアビル5F' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
