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
#  role                   :string(255)      default("user")
#

require 'spec_helper'

describe User do

  before { @user = User.new(name: 'Ads User',
                            email: 'email@ads.com',
                            password: 'password',
                            password_confirmation: 'password',
                            remember_me: '0') }


  subject { @user }

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

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is nil" do
    before { @user.name = nil }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email is nil" do
    before { @user.email = nil }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[foo@bar,com foo_at_bar.org foo.bar@foo.
                     foo@bar_foo.com foo@bar+foo.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[foo@bar.COM f_o-o@b.a.r foo.bar@foo.su
                     foo@bar.foo.com foo1812@bar.fr]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email address is alredy taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password is nil" do
    before { @user.password = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5}
    it { should be_invalid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "ad associations" do
    before { @user.save }
    let!(:older_ad) do
      FactoryGirl.create(:ad, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_ad) do
      FactoryGirl.create(:ad, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right ads in the right order" do
      @user.ads.should == [newer_ad, older_ad]
    end

    it "should destroy associated ads" do
      ads = @user.ads
      @user.destroy
      ads.each do |ad|
        Ad.find_by_id(ad.id).should be_nil
      end
    end
  end

  describe "with default role" do
    before { @user.save }
    it { @user.role.should == 'user' }
  end
end
