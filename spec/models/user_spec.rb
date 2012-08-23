# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do

  before { @user = User.new(name: "John Doe",
                            email: "john.doe@email.com",
                            password: "foobar",
                            password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:ads) }

  it { should be_valid }

  # name validation
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  # email validation
  describe "when email is not present" do
    before { @user.email = " " }
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

  # password validation
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email (@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5}
    it { should be_invalid }
  end

  # remember_token validation
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
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
end
