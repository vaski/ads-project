# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  role                   :string(255)
#

require 'spec_helper'

describe User do

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_me) }
  it { should respond_to(:role) }
  it { should respond_to(:id) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:reset_password_token) }
  it { should respond_to(:reset_password_sent_at) }
  it { should respond_to(:remember_created_at) }
  it { should respond_to(:sign_in_count) }
  it { should respond_to(:current_sign_in_at) }
  it { should respond_to(:last_sign_in_at) }
  it { should respond_to(:current_sign_in_ip) }
  it { should respond_to(:last_sign_in_ip) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:ads) }
  it { should have_many(:ads) }
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }
  it { should_not allow_mass_assignment_of(:id) }
  it { should_not allow_mass_assignment_of(:encrypted_password) }
  it { should_not allow_mass_assignment_of(:reset_password_token) }
  it { should_not allow_mass_assignment_of(:reset_password_sent_at) }
  it { should_not allow_mass_assignment_of(:remember_created_at) }
  it { should_not allow_mass_assignment_of(:sign_in_count) }
  it { should_not allow_mass_assignment_of(:current_sign_in_at) }
  it { should_not allow_mass_assignment_of(:last_sign_in_ip) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should_not allow_mass_assignment_of(:role) }
  it { should validate_presence_of(:name) }
  it { should_not allow_value('a' * 81).for(:name) }
  it { should_not allow_value('').for(:name) }
  it { should_not allow_value(nil).for(:name) }
  it { should allow_value('User name').for(:name) }
  it { should validate_presence_of(:email) }
  it { should_not allow_value('').for(:email) }
  it { should_not allow_value(nil).for(:email) }
  it { should_not allow_value('wrong.email').for(:email) }
  it { should allow_value('email@ads.com').for(:email) }
  it { should validate_presence_of(:password) }
  it { should_not allow_value('a' * 5).for(:password) }
  it { should_not allow_value('').for(:password) }
  it { should_not allow_value(nil).for(:password) }
  it { should allow_value('password').for(:password) }
  it { should_not validate_presence_of(:password_confirmation) }
  it { should allow_value(nil).for(:password_confirmation) }
  it { should allow_value('password').for(:password_confirmation) }
  it { should_not validate_presence_of(:remember_me) }
  it { should allow_value(1).for(:remember_me) }

  describe 'with valid data' do
    let(:user) { FactoryGirl.build(:user) }

    describe "when password doesn't match confirmation" do
      before { user.password_confirmation = 'mismatch' }
      it { should_not be_valid }
    end

    describe 'ad associations' do
      let(:ad) { FactoryGirl.create(:ad, user: user) }

      it 'should destroy associated ads' do
        ads = user.ads
        user.destroy
        ads.each do |ad|
          Ad.find_by_id(ad.id).should be_nil
        end
      end
    end

    describe "when email address is alredy taken" do
      before do
        user_with_same_email = user.dup
        user_with_same_email.email = user.email.upcase
      end

      it { should_not be_valid }
    end

    describe 'after save' do
      before { user.save }
      it { user.role.should == 'user' }
    end
  end
end
