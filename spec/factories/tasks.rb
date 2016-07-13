FactoryGirl.define do
  factory :task do
    sequence(:name) {|i| "name#{i}" }
    sequence(:description) {|i| "description#{i}" }
  end
end
