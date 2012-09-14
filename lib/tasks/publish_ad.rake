namespace :db do
  desc "Change ad status from :approved to :published"
  task publish_ads: :environment do
    ads = Ad.where(state: 'approved')
    ads.each do |ad|
      ad.state = 'published'
      ad.save
    end
  end
end
