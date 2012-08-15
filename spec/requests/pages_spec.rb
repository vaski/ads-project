require 'spec_helper'


describe "Pages" do
 
  describe "Home" do
    it "should have the content 'Welcome'" do
      visit '/pages/home'
      page.should have_content('Welcome')
    end
  end

  it "should have the right title" do
    visit '/pages/home'
    page.should have_selector('title', :text => "ADS project | Home")
  end
end
