require 'spec_helper'

RSpec::Mocks.configuration.syntax = :should

describe Travis::Topaz do
  before do
    Travis::Topaz.setup
  end

  describe '#update' do
    let(:event_data) { { sample: "event_data" } }
    context 'Queue has less than 100 waiting updates' do
      it 'sends post request to topaz app' do
        Travis::Topaz.update(event_data)
        expect(a_request(:post, "https://travis-pro-topaz-staging.herokuapp.com/event/new")).to have_been_made.once
      end
    end

    context 'Queue has 100 or more waiting updates' do
      before do
        Travis::Topaz.queue.stub(:num_waiting).and_return(101)
      end
      it 'does not post request topaz app' do
        Travis::Topaz.update(event_data)
        expect(a_request(:post, "https://travis-pro-topaz-staging.herokuapp.com/new_event")).not_to have_been_made
      end
    end
  end
end
