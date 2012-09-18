# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  category_name :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Category < ActiveRecord::Base
  attr_accessible :category_name
  has_many :categorizations, dependent: :restrict
  has_many :ads, through: :categorizations

  validates :category_name, presence: true,
                    length: { maximum: 80 }

end
