FactoryGirl.define do
  factory :item do
    name "Kitten Tank Top"
    description "The cutest of all tank tops you could ever own!"
    price 19.99
  end

  factory :address do
    city "Los Angeles"
    state "California"
    country "United States"
    street_address "6122 Fluffy Ave"
    zipcode "91662"
    type_of "shipping"
    user

    factory :shipping_address do
      type_of "shipping"
    end

    factory :billing_address do
      type_of "billing"
    end
  end

  factory :user do
    first_name "Toni"
    last_name "Rib"
    email "toni@example.com"
    company

    factory :user_with_addresses do
      after(:create) do |user, _|
        create(:shipping_address, user: user)
        create(:billing_address, user: user)
      end
    end
  end

  factory :company do
    name "Cat Fantastic"
    city "Denver"
    state "Colorado"
    country "United States"
    street_address "123 Meow Lane"
    zipcode "80210"
    phone "2120138413"
  end
end
