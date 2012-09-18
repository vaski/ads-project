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

require 'spec_helper'

describe Categorization do

  it { should respond_to(:id) }
  it { should respond_to(:ad_id) }
  it { should respond_to(:category_id) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should_not respond_to(:ads) }
  it { should_not respond_to(:categories) }
  it { should belong_to(:ad) }
  it { should belong_to(:category) }
  it { should_not allow_mass_assignment_of(:id) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should allow_mass_assignment_of(:ad_id) }
  it { should allow_mass_assignment_of(:category_id) }
  it { should validate_numericality_of(:ad_id) }
  it { should validate_numericality_of(:category_id) }
end
