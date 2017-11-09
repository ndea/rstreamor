module Rstreamor
  class Response
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def response_code
      request.range_header? ? 206 : 200
    end

    def content_length
      if request.range_header?
        (request.upper_bound - request.lower_bound).to_s
      else
        request.file_size
      end
    end

    def content_range
      "bytes #{ request.lower_bound }-#{ request.upper_bound - 1 }/#{ request.file_size }"
    end

    def accept_ranges
      'bytes'
    end

    def cache_control
      'no-cache'
    end
  end
end
