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

require 'spec_helper'

describe Ad do

  let(:user) { FactoryGirl.create(:user) }
  before { @ad = user.ads.build(title: "Lorem", description: "Lorem ipsum") }

  subject { @ad }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @ad.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @ad.title = " " }
    it { should_not be_valid }
  end

  describe "with blank description" do
    before { @ad.description = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @ad.title = "a" * 81 }
    it { should_not be_valid }
  end
end
