module Harvest
  module API
    class Base
      attr_reader :credentials
      
      def initialize(credentials)
        @credentials = credentials
      end
      
      class << self
        def api_model(klass)
          class_eval <<-END
            def api_model
              #{klass}
            end
          END
        end
      end
      
      protected
        def request(method, credentials, path, options = {})
          response = HTTParty.send(method, "#{credentials.host}#{path}", :query => options[:query], :body => options[:body], :headers => {"Accept" => "application/xml", "Content-Type" => "application/xml; charset=utf-8", "Authorization" => "Basic #{credentials.basic_auth}", "User-Agent" => "Harvestable/#{Harvest::VERSION}"}.update(options[:headers] || {}), :format => :plain)
          case response.code
          when 200..201
            response
          when 400
            raise Harvest::BadRequest.new(response)
          when 401
            raise Harvest::InvalidLogin.new(response)
          when 404
            raise Harvest::NotFound.new(response)
          when 500
            raise Harvest::ServerError.new(response)
          when 502
            raise Harvest::Unavailable.new(response)
          when 503
            raise Harvest::RateLimited.new(response)
          else
            raise Harvest::InformHarvest.new(response)
          end
        end
    end
  end
end
