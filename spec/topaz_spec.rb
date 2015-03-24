require 'spec_helper'

describe Travis::Topaz do
  before do
    Travis::Topaz.setup
  end

  describe '#update' do
    let(:event_data) { { sample: "event_data" } }
    context 'Queue has less than 100 waiting updates' do
      it 'sends post request to topaz app' do
        Travis::Topaz.update(event_data)
        expect(a_request(:post, "https://travis-pro-topaz-staging.herokuapp.com/new_event")).to have_been_made.once
      end
    end

    # context 'Queue has 100 or more waiting updates' do
    #   before do
    #     Travis::Topaz.queue.stubs(:num_waiting).returns(101)
    #   end
    #   it 'does not post request topaz app' do
    #     expect(a_request(:post, "https://travis-pro-topaz-staging.herokuapp.com/new_event").to not_have_been_made.once)
    #     Travis::Topaz.update(event_data)
    #   end
    #   # expect event_data to NOT be posted to the url if queue.num_waiting => 100
    # end
  end
end
