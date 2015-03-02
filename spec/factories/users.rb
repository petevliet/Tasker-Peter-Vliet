FactoryGirl.define do
  factory :user do |f|
    f.first_name 'joe'
    f.last_name 'example'
    f.email 'joe@example.com'
    f.password 'password'
  end
end
