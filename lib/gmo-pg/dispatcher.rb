require 'gmo-pg/dispatcher/shorthands'

module GMO
  module PG
    class Dispatcher
      extend Forwardable
      include Shorthands

      def_delegators :@http,
        :open_timeout, :open_timeout=,
        :read_timeout, :read_timeout=

      def initialize(base_url)
        url = URI.parse(base_url)
        @http = Net::HTTP.new(url.host, url.port)
        @http.use_ssl = true if url.scheme == 'https'
        yield self if block_given?
      end

      def use_proxy(address: :ENV, port: nil, user: nil, pass: nil)
        @http.proxy_from_env = (address == :ENV)
        @http.proxy_address  = address
        @http.proxy_port     = port
        @http.proxy_user     = user
        @http.proxy_pass     = pass
        self
      end

      def connect
        @http.start { yield self if block_given? }
      end

      def dispatch(request)
        req = Net::HTTP::Post.new(request.path)
        req.body = GMO::PG::Payload.encode(request.payload)
        res = @http.request(req)
        case res
        when Net::HTTPSuccess
          payload = GMO::PG::Payload.decode(res.body)
          request.class.corresponding_response_class.new(payload)
        else
          res.value
        end
      end
    end
  end
end
