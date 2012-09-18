# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  category_name :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Category do

  it { should respond_to(:id) }
  it { should respond_to(:category_name) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:ads) }
  it { should_not respond_to(:categorization) }
  it { should have_many(:ads) }
  it { should have_many(:categorizations) }
  it { should_not allow_mass_assignment_of(:id) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should allow_mass_assignment_of(:category_name) }
  it { should validate_presence_of(:category_name) }
  it { should_not allow_value('a' * 81).for(:category_name) }
  it { should_not allow_value('').for(:category_name) }
  it { should_not allow_value(nil).for(:category_name) }
  it { should allow_value('toys and games').for(:category_name) }
end
