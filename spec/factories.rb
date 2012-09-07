FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "email_#{n}@ads.com" }
    password              "password"
    password_confirmation "password"

    factory :admin do
      name                  "Admin"
      email                 "admin@ads.com"
      password              "password"
      password_confirmation "password"
      role                  "admin"
    end
  end

  factory :ad do
    title "Lorem ipsum"
    description "Lorem ipsum dolor sit amet"
    user
  end
end
