require 'spec_helper'

describe 'Guest' do

  forbidden_urls = [ '/ads/new',
                     '/categories',
                     '/categories/new',
                     '/users',
                     '/users/new',
                     '/verified_ads']

  forbidden_urls.each do |url|
    it "can not access #{url}" do
      get url
      response.should redirect_to(root_path)
    end
  end
end
