namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    @admin = User.create!({name: "Ads Admin",
                           email: "admin@ads.com",
                           password: "password",
                           password_confirmation: "password",
                           role: "admin"},
                           without_protection: true)

    5.times do |n|
      name = Faker::Name.name
      email = "email-#{n+1}@ads.com"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.sentence(3)
      description = Faker::Lorem.sentence(25)
      users.each do |user|
        user.ads.create!(title: title,
                         description: description)
      end
    end
  end
end
