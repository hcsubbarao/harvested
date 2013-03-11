module Harvest
  module API
    class Invoices < Base
      api_model Harvest::Invoice
      
      include Harvest::Behavior::Crud
      
      def all(page=1)
        response = request(:get, credentials, "#{api_model.api_path}", :query => "page=#{page}")
        api_model.parse(response.body)
      end
    end
  end
end