require 'spec_helper'

describe "Pages" do

  describe "Home" do
    it "should have the content 'Welcome'" do
      visit '/'
      page.should have_content('Welcome')
    end

    it "should have the right title" do
      visit '/'
      page.should have_selector('title', :text => "ADS project | Home")
    end
  end

  describe "Sign up" do
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

      it "should create a user" do
        expect { click_button submit }.to change(User, :count)
      end
    end
  end
end
