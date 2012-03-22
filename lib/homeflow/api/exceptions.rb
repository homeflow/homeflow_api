module Homeflow
  module API
    module Exceptions
      class InvalidResponse < StandardError; end
      class UnknownAPIError < StandardError; end
      class APIArgumentError < StandardError; end
      class APIConnectionError < StandardError; end

      class ExceptionsList
        def self.list
          [InvalidResponse,APIArgumentError,UnknownAPIError]
        end
      end

    end
  end
end