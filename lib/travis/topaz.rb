require 'travis/topaz/version'
require 'travis/support/logger'

module Travis
  module Topaz
    class << self
      attr_accessor :queue

      def setup(url)
        return if @queue
        Travis.logger.info("Setting up Topaz")
        @queue = ::SizedQueue.new(100)
        conn = Faraday.new

        Thread.new do
          loop do
            begin
              Travis.logger.info("Waiting for Topaz event")
              event = queue.pop
              Travis.logger.info("Posting event to Topaz with the following data: #{event}")
              conn.post url + '/event/new', event
            rescue => e
              Travis.logger.info([e.message, e.backtrace].flatten.join("\n"))
            end
          end
        end
      end

      def update(event)
        return unless queue && queue.num_waiting < 100
        Travis.logger.info("Pushing Topaz Event to queue")
        queue.push(event)
      end
    end
  end
end
