FactoryGirl.define do
  factory :address do
    city "Los Angeles"
    state "California"
    country "United States"
    street_address "6122 Fluffy Ave"
    zipcode "91662"
    type_of "shipping"
    user
  end

  factory :user do
    first_name "Toni"
    last_name "Rib"
    email "toni@example.com"
    company
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
