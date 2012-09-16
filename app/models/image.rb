# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  image_url  :string(255)
#  ad_id      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ActiveRecord::Base
  attr_accessible :image_url
  belongs_to :ad

  after_save do |img|
    img.ad.refresh
  end

  after_destroy do |img|
    img.ad.refresh
  end
end
