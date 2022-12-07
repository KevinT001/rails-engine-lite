require 'faker'
FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Company.name }
  end

  factory :item, class: Item do 
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.material }
    unit_price { Faker::Commerce.price }
    merchant
  end
end
