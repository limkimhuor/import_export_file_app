FactoryGirl.define do
  factory :product do
    name Faker::Commerce.product_name
    released_on Faker::Date.between(6.months.ago, 6.months.from_now)
    price Faker::Commerce.price
  end
end
