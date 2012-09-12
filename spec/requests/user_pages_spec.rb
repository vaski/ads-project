require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "As user" do

    describe "Account page" do
      let(:user) { FactoryGirl.create(:user) }
      let!(:ad1) { FactoryGirl.create(:ad, user: user, title: "First Ad", description: "Lorem ipsum") }
      let!(:ad2) { FactoryGirl.create(:ad, user: user, title: "Second Ad", description: "Sed nisi ligula") }

      before do
        user_sign_in(user)
        visit user_path(user)
      end

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

    describe "Account page" do
      let(:admin) { FactoryGirl.create(:admin) }

      let!(:ad1) { FactoryGirl.create(:ad, user: admin, title: "First Ad", description: "Lorem ipsum") }
      let!(:ad2) { FactoryGirl.create(:ad, user: admin, title: "Second Ad", description: "Sed nisi ligula") }

      before do
        user_sign_in(admin)
        visit user_path(admin)
      end

      it { should have_selector('h1', text: admin.name) }
      it { should have_selector('title', text: admin.name) }
      it { should have_selector('a', text: "Create new ad!") }

      it { should have_content(admin.id) }
      it { should have_content(admin.email) }
      it { should have_content(admin.role) }
      it { should have_content(admin.ads.count) }

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

    describe "Index page" do

      let(:admin) { FactoryGirl.create(:admin) }
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      before(:each) do
        user_sign_in admin
        visit users_path
      end

      it { should have_selector('title', text: 'All users') }
      it { should have_selector('h1', text: 'All users') }
      it { should have_selector('a', text: 'Delete') }

      describe "pagination" do

        it { should have_selector('div.pagination') }

        it "should list each user" do
          User.paginate(page: 1).each do |user|
            page.should have_selector('a', text: user.name)
          end
        end
      end

      describe "deleting user" do
        before { click_link 'Delete' }
        it { should have_selector('div', text: 'User destroyed!') }
      end

      it "should delete a user" do
        expect { click_link 'Delete' }.to change(User, :count).by(-1)
      end

    end

    describe "Nav bar" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        user_sign_in admin
      end

      it { should have_link('Users', href: users_path) }

    end
  end
end
