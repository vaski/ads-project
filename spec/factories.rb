FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "email_#{n}@ads.com" }
    password              "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :ad do
    title "Lorem ipsum"
    description "Lorem ipsum dolor sit amet"
    user
  end
end
