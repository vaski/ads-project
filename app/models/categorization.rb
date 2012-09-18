# == Schema Information
#
# Table name: categorizations
#
#  id          :integer          not null, primary key
#  ad_id       :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Categorization < ActiveRecord::Base
  attr_accessible :ad_id, :category_id
  belongs_to :ad
  belongs_to :category

  validates :ad_id, numericality: true
  validates :category_id, numericality: true

  after_save do |ctg|
    ctg.ad.refresh
  end

  after_destroy do |ctg|
    ctg.ad.refresh
  end

end
