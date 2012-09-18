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

require 'spec_helper'

describe Image do

  it { should respond_to(:id) }
  it { should respond_to(:image_url) }
  it { should respond_to(:ad_id) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:ad) }
  it { should belong_to(:ad) }
  it { should_not allow_mass_assignment_of(:id) }
  it { should allow_mass_assignment_of(:image_url) }
  it { should_not allow_mass_assignment_of(:ad_id) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should validate_presence_of(:image_url) }
  it { should allow_value('image.png').for(:image_url) }
  it { should_not allow_value('image.com').for(:image_url) }
  it { should_not allow_value('imagepng').for(:image_url) }
  it { should_not allow_value('a' * 256).for(:image_url) }
  it { should_not allow_value(nil).for(:image_url) }
  it { should_not allow_value('').for(:image_url) }
end
