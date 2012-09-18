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
#  state       :string(255)
#

class Ad < ActiveRecord::Base
  attr_accessible :description, :title, :images_attributes, :category_ids
  belongs_to :user
  has_many :images, dependent: :destroy, autosave: :true
  has_many :categorizations, dependent: :destroy, autosave: :true
  has_many :categories, through: :categorizations
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, presence: true,
                    length: { maximum: 80 }

  validates :description, presence: true,
                          length: { maximum: 500 }

  validates :user_id, presence: true

  default_scope order: 'ads.updated_at DESC'

  before_save do |ad|
    ad.state = 'draft' if ad.title_changed? || ad.description_changed?
  end

  state_machine :state, initial: :draft do

    event :verify do
      transition draft: :verified
    end

    event :approve do
      transition verified: :approved
    end

    event :reject do
      transition verified: :rejected
    end

    event :publish do
      transition approved: :published
    end

    event :archive do
      transition published: :archived
    end

    event :refresh do
      transition all - [:draft] => :draft
    end
  end
end
