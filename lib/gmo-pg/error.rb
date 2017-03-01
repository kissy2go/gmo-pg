module GMO
  module PG
    class Error < StandardError
      def self.from_http_error(e)
        case e
        when Timeout::Error
          GMO::PG::ConnectionError.new(e.message)
        when Net::HTTPError,
             Net::HTTPRetriableError,
             Net::HTTPServerException,
             Net::HTTPFatalError,
             Net::HTTPBadResponse,
             Net::HTTPHeaderSyntaxError
          GMO::PG::HTTPError.new(e.message)
        else
          new(e.message)
        end
      end

      def self.from_api_error(err_code, err_info)
        case err_info
        when /\AE01(01|02|03|19|20|21)/
          # E0101: Invalid ShopID
          # E0102: Invalid ShopPass
          # E0103: Invalid ShopID and/or ShopPass
          # E0119: Invalid SiteID
          # E0120: Invalid SitePass
          # E0121: Invalid SiteID and/or SitePass
          GMO::PG::AuthorizationError.new('Authorization error', err_code, err_info)
        when /\AE01(17|18|25|26|27|46|48)/, /\A(E41|42G)/, /\AE61010002\Z/
          # E0117    : Invalid CardNo
          # E0118    : Invalid Expire
          # E0125    : Invalid CardPass
          # E0126    : Invalid Method
          # E0127    : Invalid PayTimes
          # E0146    : Invalid SecurityCode
          # E0148    : Invalid HolderName
          # E41      : Incorrect card
          # 42G      : Error on Card brand
          # E61010002: Incorrect card or invalid CardNo
          GMO::PG::CardError.new('Card error', err_code, err_info)
        when /\A(E61|E91|E92|42C)/
          # E61: Shop configuration error
          # E91: System error
          # E92: Temporary unavailable
          # 42C: Error on CAFIS or Card brand
          GMO::PG::APIServerError.new('Temporary unavailable', err_code, err_info)
        else
          GMO::PG::APIError.new('API error', err_code, err_info)
        end
      end
    end

    class ConnectionError < Error
    end

    class HTTPError < Error
    end

    class APIError < Error
      attr_reader :err_code, :err_info

      def initialize(message, err_code, err_info)
        super("#{message} (#{err_code}|#{err_info})")
        @err_code = err_code
        @err_info = err_info
      end
    end

    class AuthorizationError < APIError
    end

    class CardError < APIError
    end

    class APIServerError < APIError
    end
  end
end
