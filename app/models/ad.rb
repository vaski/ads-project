# == Schema Information
#
# Table name: ads
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Ad < ActiveRecord::Base
  attr_accessible :description, :title

  belongs_to :user

  validates :title, presence: true,
                    length: { maximum: 80 }

  validates :description, presence: true

  validates :user_id, presence: true

  default_scope order: 'ads.updated_at DESC'
end
