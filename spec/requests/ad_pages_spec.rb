require 'spec_helper'

describe "Ad pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "ad creation" do
    before { visit user_path(user) }

    describe "with invalid information" do
      it "should not create an ad" do
        expect { click_button "Create" }.should_not change(Ad, :count)
      end

      describe "error message" do
        before { click_button "Create" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
       fill_in "Lorem ipsum", with: ad.title
       fill_in "Lorem ipsum dolor", with: ad.description
      end

      it "should create an ad" do
        expect { click_button "Create" }.should change(Ad, :count).by(1)
      end
    end
  end
end
