require 'spec_helper'

describe Travis::Topaz do
  
  before do
    stub_request(:post, "https://travis-pro-topaz-staging.herokuapp.com/new_event").with(:body => {"foo"=>"bar"},:headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.9.1'}).to_return(:status => 200, :body => "", :headers => {})
    stub_request(:post, "https://travis-pro-topaz-staging.herokuapp.com/new_event").with(:body => {"foo"=>"bar"}, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.9.1'}).to_return(:status => 200, :body => "", :headers => {})
  end

  context '#update' do
    # let(:xxx) { '' }
    # let(:xxx) {  }

    # expect event data to be posted to the url using faraday if queue.num_waiting < 100

    # expect event_data to NOT be posted to the url if queue.num_waiting => 100
  end



end