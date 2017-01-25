module GMO
  module PG
    module APIEndpoint
      def endpoint_path
        "/payment/#{self.name.split('::')[-1]}.idPass"
      end
    end
  end
end

require 'gmo/pg/api_endpoint/entry_tran'
require 'gmo/pg/api_endpoint/exec_tran'
require 'gmo/pg/api_endpoint/secure_tran'
require 'gmo/pg/api_endpoint/save_member'
require 'gmo/pg/api_endpoint/update_member'
require 'gmo/pg/api_endpoint/delete_member'
require 'gmo/pg/api_endpoint/search_member'
require 'gmo/pg/api_endpoint/save_card'
require 'gmo/pg/api_endpoint/delete_card'
require 'gmo/pg/api_endpoint/search_card'
require 'gmo/pg/api_endpoint/alter_tran'
require 'gmo/pg/api_endpoint/change_tran'
require 'gmo/pg/api_endpoint/search_trade'
require 'gmo/pg/api_endpoint/traded_card'
require 'gmo/pg/api_endpoint/search_card_detail'
