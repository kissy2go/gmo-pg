require 'gmo-pg/version'

require 'gmo-pg/dispatcher'
require 'gmo-pg/http_resource'
require 'gmo-pg/api_endpoint'

module GMO
  module PG
    @base_url     = 'https://p01.mul-pay.jp'
    @open_timeout = 60
    @read_timeout = 90

    class << self
      attr_accessor :base_url, :open_timeout, :read_timeout, :proxy
    end

    def self.connect(&block)
      dispatcher = Dispatcher.new(base_url) do |d|
        d.open_timeout = open_timeout
        d.read_timeout = read_timeout
        d.use_proxy proxy if proxy
      end
      dispatcher.connect(&block)
    end
  end
end
