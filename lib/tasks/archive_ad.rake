namespace :db do
  desc "Change ad status from :published to :archived"
  task archive_ads: :environment do
    deadline = Time.now.midnight - 3.day
    ads = Ad.where("updated_at < ? AND state == 'published'", deadline)
    ads.each do |ad|
      ad.state = 'archived'
      ad.save
    end
  end
end
