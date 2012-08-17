FactoryGirl.define do
  factory :user do
    name                  "Foo Bar"
    email                 "foo@bar.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end
