module Dashing
    class EventsController < ApplicationController
      include ActionController::Live
      #before_action :authenticate_user!
      
      def index
        if user_signed_in?
          @redis = Dashing.redis  
          response.headers['Content-Type']      = 'text/event-stream'
          response.headers['X-Accel-Buffering'] = 'no'
          response.stream.write latest_events
          
        end    
          rescue IOError
            logger.info "[Dashing][#{Time.now.utc.to_s}] Stream closed"
          ensure
            #@redis.shutdown { |redis_connection| redis_connection.quit }
          response.stream.close
        
      end
  
      def latest_events
        @redis.with do |redis_connection|
          events = redis_connection.hvals("#{Dashing.config.redis_namespace}.latest")
          events.map { |v| "data: #{v}\n\n" }.join
        end
      end
    end
  end
  