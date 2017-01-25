require 'gmo/pg/dispatcher/shorthands'

module GMO
  module PG
    class Dispatcher
      extend Forwardable
      include Shorthands

      attr_reader :base_url
      attr_accessor :raise_on_api_error

      def_delegators :@http,
        :open_timeout, :open_timeout=,
        :read_timeout, :read_timeout=,
        :proxy_address, :proxy_port, :proxy_user, :proxy_pass
      def_delegator :@http, :started?, :connected?

      def initialize(base_url)
        @base_url = base_url
        url = URI.parse(@base_url)
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
        handle_http_error do
          @http.start { yield self if block_given? }
        end
      end

      def dispatch(request)
        req = Net::HTTP::Post.new(request.path)
        req.body = GMO::PG::Payload.encode(request.payload)

        handle_http_error do
          res = @http.request(req)
          case res
          when Net::HTTPSuccess
            payload = GMO::PG::Payload.decode(res.body)
            response = request.class.corresponding_response_class.new(payload)
            handle_api_error request, response if @raise_on_api_error
            response
          else
            res.value # raise Net::XxxError
          end
        end
      end

      private

      def handle_http_error
        begin
          yield if block_given?
        rescue => e
          raise GMO::PG::Error.from_http_error(e)
        end
      end

      def handle_api_error(request, response)
        return response unless response.error?

        raise response.errors.first.to_error.tap do |e|
          e.request  = request
          e.response = response
        end
      end
    end
  end
end
