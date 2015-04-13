require 'travis/topaz/version'
require 'travis/support/logger'

module Travis
  module Topaz
    class << self
      attr_accessor :queue

      def setup(url)
        Travis.logger.info("Setting up Topaz")
        @queue = ::SizedQueue.new(100)
        Travis.logger.info("Topaz Queue created")
        conn = Faraday.new
        Travis.logger.info("Topaz Faraday connection created")

        Thread.new do
          loop do
            begin
              event = queue.pop
              conn.post url + '/event/new', event
              Travis.logger.info("A post request has been added to the queue with the following data: #{event}")
            rescue => e
              Travis.logger.info([e.message, e.backtrace].flatten.join("\n"))
            end
          end
        end
      end

      def update(event)
        queue.push(event) if queue && queue.num_waiting < 100
        Travis.logger.info("Topaz Event added to queue")
      end
    end
  end
end
