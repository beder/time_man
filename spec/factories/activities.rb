FactoryGirl.define do
  factory :activity do
    sequence(:name) { |n| "Activity #{n}" }
    sequence(:date) { |n| Date.today - n }
    sequence(:hours)
    user { create(:user) }
  end
end