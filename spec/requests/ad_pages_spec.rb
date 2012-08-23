require 'spec_helper'

describe "Ad pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "ad creation" do
    before { visit new_ad_path }

    describe "with invalid information" do
      it "should not create an ad" do
        expect { click_button "Create Ad" }.not_to change(Ad, :count)
      end

      describe "should have error message" do
        before { click_button "Create Ad" }
        it { should have_content('Ad not created!') }
      end
    end

    describe "with valid information" do

      before do
        fill_in 'ad_title', with: "Unique title for unique ad"
        fill_in 'ad_description', with: "Lorem ipsum dolor"
      end

      it "should create an ad" do
        expect { click_button "Create Ad" }.to change(Ad, :count).by(1)
      end

      describe "should have message" do
        before { click_button "Create Ad" }
        it { should have_content('Ad created!') }
      end

      describe "should have ad content" do
        before { click_button "Create Ad" }
        it { should have_content('Unique title for unique ad') }
      end

      describe "should redirect to current user page" do
        before { click_button "Create Ad" }
        it { should have_content( user.name ) }
      end
    end

    describe "when click cancel button" do
      before { click_link "Cancel" }
      it { should have_content( user.name ) }
    end
  end

  describe "ad destruction" do
    before { FactoryGirl.create(:ad, user: user) }

      describe "as correct user" do
      before { visit user_path(id: user.id) }

      it "should delete a ad" do
        expect { click_link "delete" }.to change(Ad, :count).by(-1)
      end
    end
  end
end
