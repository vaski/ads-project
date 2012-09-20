require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "As guest" do
    before { visit root_path }

    it { should have_link('Sign in', href: new_user_session_path) }
  end

  describe "As user" do
    let(:user) { FactoryGirl.create(:user) }
    before { user_sign_in(user) }

    it { should have_link('Create ad', href: new_ad_path) }
    it { should have_link('My account', href: user_path(user)) }
    it { should have_link('Settings', href: edit_user_registration_path) }
    it { should have_link('Sign out', href: destroy_user_session_path) }


    describe "Account page" do
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


      describe "ads list" do

        it { should have_content(ad1.title) }
        it { should have_content(ad1.description) }
        it { should have_content(ad2.title) }
        it { should have_content(ad2.description) }
        it { should have_selector('a', text: "edit")}
        it { should have_selector('a', text: "delete")}

        describe "creating ad" do
          before { click_link 'Create new ad!' }
          it { should have_selector('h1', text: 'New ad') }
        end

        describe "updating ad" do
          before { click_link 'edit' }
          it { should have_selector('h1', text: 'Edit ad') }
        end

        describe "deleting ad" do
          before { click_link 'delete' }
          it { should have_selector('div', text: 'Successfuly destroyed ad!' ) }
        end

        it "should delete a ad" do
          expect { click_link 'delete' }.to change(Ad, :count).by(-1)
        end
      end
    end
  end

  describe "As admin" do
    let(:admin) { FactoryGirl.create(:admin) }
    before { user_sign_in admin }

    it { should have_link('Users', href: users_path) }
    it { should have_link('Verified ads', href: verified_ads_path) }
    it { should have_link('My account', href: user_path(admin)) }
    it { should have_link('Settings', href: edit_user_registration_path) }
    it { should have_link('Sign out', href: destroy_user_session_path) }


    describe "Account page" do
      before { visit user_path(admin) }

      it { should have_selector('h1', text: admin.name) }
      it { should have_selector('title', text: admin.name) }
      it { should have_content(admin.id) }
      it { should have_content(admin.email) }
      it { should have_content(admin.role) }
    end

    describe "Index page" do
      before { visit users_path }

      it { should have_selector('title', text: 'All users') }
      it { should have_selector('h1', text: 'All users') }
      it { should have_selector('a', text: 'Change role') }
      it { should have_link('Users', href: users_path) }

      describe "deleting user" do
        before(:all) { 2.times { FactoryGirl.create(:user) } }
        after(:all) { User.delete_all }
        before { click_link 'Delete' }

        it { should have_selector('div', text: 'User destroyed!') }

        it "should delete a user" do
          expect { click_link 'Delete' }.to change(User, :count).by(-1)
        end
      end
    end
  end
end
