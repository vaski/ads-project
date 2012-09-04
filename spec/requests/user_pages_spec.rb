require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "Sign up page" do
    before { visit signup_path }

    it "should have the content 'Sign up'" do
      visit '/signup'
      page.should have_content('Sign up')
    end

    it "should have the right title" do
     visit '/signup'
     page.should have_selector('title', :text => "ADS project | Sign up")
    end

    before { visit signup_path }
    let(:submit) { "Create User" }

    describe "with invalid information" do
      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_selector('div', class: 'error') }
      end

      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",                  with: "Foo Bar"
        fill_in "Email",                 with: "foo@bar.com"
        fill_in "Password",              with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('foo@bar.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert', text: 'Welcome') }
        it { should have_link('Sign out') }
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:ad1) { FactoryGirl.create(:ad, user: user, title: "First Ad", description: "Lorem ipsum") }
    let!(:ad2) { FactoryGirl.create(:ad, user: user, title: "Second Ad", description: "Sed nisi ligula") }

    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
    it { should have_selector('a', text: "Create new ad!") }
    it { should have_content(user.id) }
    it { should have_content(user.email) }
    it { should have_content(user.role) }
    it { should have_content(user.ads.count) }


    describe "ads" do
      it { should have_content(ad1.title) }
      it { should have_content(ad1.description) }
      it { should have_content(ad2.title) }
      it { should have_content(ad2.description) }
      it { should have_content(user.ads.count) }
    end
  end

  describe "Edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1', text: "Update your profile") }
      it { should have_selector('title', text: "Update profile") }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@ads.com" }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password
        click_button "Update User"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end

    describe "with invalid information" do
      before { click_button "Update User" }

      it { should have_selector('div', class: 'error') }
    end
  end
end
