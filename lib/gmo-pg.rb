require 'gmo-pg/version'

require 'gmo-pg/http_resource'
require 'gmo-pg/api_endpoint'
require 'gmo-pg/dispatcher'
require 'gmo-pg/error'
require 'gmo-pg/util'

module GMO
  module PG
    @open_timeout       = 60
    @read_timeout       = 90
    @raise_on_api_error = true

    class << self
      attr_accessor :base_url, :open_timeout, :read_timeout, :proxy, :raise_on_api_error
    end

    def self.connect(base_url = self.base_url, &block)
      dispatcher = Dispatcher.new(base_url) do |d|
        d.open_timeout       = open_timeout
        d.read_timeout       = read_timeout
        d.raise_on_api_error = raise_on_api_error
        d.use_proxy proxy if proxy
      end
      dispatcher.connect(&block)
    end
  end
end
