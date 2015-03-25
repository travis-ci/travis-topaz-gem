require 'travis/topaz/version'
require 'travis/support/logger'

module Travis
  module Topaz
    class << self
      attr_accessor :queue

      def setup
        @queue = ::SizedQueue.new(100)
        conn = Faraday.new

        Thread.new do
          loop do
            begin
              event = queue.pop
              conn.post 'https://travis-pro-topaz-staging.herokuapp.com/new_event', event
              Travis.logger.info("A post request has been added to the queue with the following data: #{event}")
            rescue => e
              Travis.logger.info([e.message, e.backtrace].flatten.join("\n"))
            end
          end
        end
      end

      def update(event)
        queue.push(event) if queue && queue.num_waiting < 100
      end
    end
  end
end
