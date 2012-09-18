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

require 'spec_helper'

describe Ad do

  it { should respond_to(:id) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:state) }
  it { should respond_to(:user) }
  it { should respond_to(:images) }
  it { should belong_to(:user) }
  it { should have_many(:images) }
  it { should_not allow_mass_assignment_of(:id) }
  it { should_not allow_mass_assignment_of(:user_id) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should_not allow_mass_assignment_of(:state) }
  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:images_attributes) }
  it { should validate_presence_of(:title) }
  it { should_not allow_value('a' * 81).for(:title) }
  it { should_not allow_value('').for(:title) }
  it { should_not allow_value(nil).for(:title) }
  it { should allow_value('Ad title').for(:title) }
  it { should validate_presence_of(:description) }
  it { should_not allow_value('a' * 501).for(:description) }
  it { should_not allow_value('').for(:description) }
  it { should_not allow_value(nil).for(:description) }
  it { should allow_value('Ad description').for(:description) }

  describe 'default state' do
    let(:user) { FactoryGirl.build(:user) }
    before { @ad = user.ads.build(title: 'Title', description: 'Description') }

    it { @ad.state.should == 'draft' }
  end
end
