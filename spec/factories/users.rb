FactoryGirl.define do
  factory :user do
    sequence(:email) {|i| "user#{i}@user.com" }
    sequence(:password) {|i| "user#{i}" }
  end
end
