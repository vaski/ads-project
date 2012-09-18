namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    5.times do |n|
      name = Faker::Name.name
      email = "email-#{n+1}@ads.com"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 5)
    5.times do
      title = Faker::Lorem.sentence(3)
      description = Faker::Lorem.sentence(25)
      users.each do |user|
        user.ads.create!(title: title,
                         description: description)
      end
    end

    images = ['01','02','03','04','05','06','07','08','09','10']
    ads = Ad.all
    ads.each do |ad|
      3.times do
        image = 'cow' + images.sample + '.png'
        ad.images.create!(image_url: image)
      end
      ad.state = 'published'
      ad.save
    end

    @admin = User.create!({name: "Ads Admin",
                           email: "admin@ads.com",
                           password: "password",
                           password_confirmation: "password",
                           role: "admin"},
                           without_protection: true)


  end
end
