module GMO
  module PG
    module Util
      module RandomString
        def self.generate(prefix: '', suffix: '', chars: [], length: 0)
          str = ''

          prefix = prefix.to_s
          suffix = suffix.to_s

          str << prefix
          (length - prefix.length - suffix.length).times { str << chars.sample }
          str << suffix
        end
      end

      module OrderID
        AVAILABLE_CHARS = [*('a'..'z'), *('A'..'Z'), *('0'..'9'), '-']
        MAX_LENGTH      = 27

        def self.generate(prefix: '', suffix: '', chars: AVAILABLE_CHARS, length: MAX_LENGTH)
          RandomString.generate(prefix: prefix, suffix: suffix, chars: chars, length: length)
        end
      end

      module MemberID
        AVAILABLE_CHARS = [*('a'..'z'), *('A'..'Z'), *('0'..'9'), '-', '@', '_', '.']
        MAX_LENGTH      = 60

        def self.generate(prefix: '', suffix: '', chars: AVAILABLE_CHARS, length: MAX_LENGTH)
          RandomString.generate(prefix: prefix, suffix: suffix, chars: chars, length: length)
        end
      end
    end
  end
end
