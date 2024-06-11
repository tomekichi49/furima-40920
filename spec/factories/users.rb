FactoryBot.define do
  factory :user do
    nickname { 'tester' }
    email { 'test@example.com' }
    password { 'a123456' }
    password_confirmation { 'a123456' }
    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birth_date { '2000-01-01' }
  end
end
