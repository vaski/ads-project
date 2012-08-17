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
end
