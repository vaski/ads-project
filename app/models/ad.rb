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
  attr_accessible :description, :title

  belongs_to :user

  validates :title, presence: true,
                    length: { maximum: 80 }

  validates :description, presence: true

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
