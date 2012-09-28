FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "email_#{n}@ads.com" }
    password              "password"
    password_confirmation "password"
    remember_me           0

    factory :admin do
      name                  "Admin"
      email                 "admin@ads.com"
      password              "password"
      password_confirmation "password"
      role                  "admin"
    end
  end

  factory :ad do
    title "Ad title"
    description "Ad description"
    user
  end

  factory :image do
    image_url "cow01.png"
    ad
  end

  factory :category do
    category_name "Category"
  end
end
