require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin/signout" do
    before { visit new_user_session_path }

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { user_sign_in user }

      it { should have_selector('title', text: 'Home') }
      it { should have_selector('div', text: 'Signed in successfully.') }

      it { should have_link('My account', href: user_path(user)) }
      it { should have_link('Settings',href: edit_user_registration_path) }
      it { should have_link('Sign out', href: destroy_user_session_path) }

      it { should_not have_link('Sign in', href: new_user_session_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end

    it { should have_selector('h1', text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe "Sign up page" do
    before { visit new_user_registration_path }

    it "should have the content 'Sign up'" do
      page.should have_content('Sign up')
    end

    it "should have the right title" do
     page.should have_selector('title', :text => "ADS project | Sign up")
    end

    let(:submit) { "Sign up" }

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

        it { should have_selector('title', text: "Home") }
        it { should have_selector('div.alert', text: 'Welcome! You have signed up successfully.') }
        it { should have_link('Sign out') }
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "Edit account" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      user_sign_in user
      visit edit_user_registration_path
    end

    it { should have_selector('title', text: 'Edit') }
    it { should have_selector('h1', text: 'Edit account') }
    it { should have_selector('a', text: 'Delete') }
    it { should have_selector('a', text: 'Cancel') }

    describe "delete account" do
      before { click_link 'Delete' }
      it { should have_selector('div', text: 'Bye! Your account was successfully cancelled.') }
    end

    it " click delete should delete a user " do
      expect { click_link 'Delete' }.to change(User, :count).by(-1)
    end

    describe "update account" do
      let(:submit) { "Update" }

      describe "with invalid information" do
        describe "after submission" do
          before { click_button submit }

          it { should have_selector('title', text: 'Edit') }
          it { should have_selector('div', class: 'error') }
        end

        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name",                  with: "New Name"
          fill_in "Email",                 with: "newname@ads.com"
          fill_in "New password",              with: "newpassword"
          fill_in "New password confirmation", with: "newpassword"
          fill_in "Current password" , with: "password"
        end

        describe "after saving the user" do
          before { click_button submit }

          it { should have_selector('title', text: "Home") }
          it { should have_selector('div.alert', text: 'You updated your account successfully.') }
        end

        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(0)
        end
      end
    end
  end
end
