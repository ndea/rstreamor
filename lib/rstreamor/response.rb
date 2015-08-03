module Rstreamor
  class Response
    attr_accessor :request

    def initialize(request)
      self.request = request
    end

    def response_code
      self.request.range_header? ? 206 : 200
    end

    def content_length
      if self.request.range_header?
        (self.request.upper_bound - self.request.lower_bound).to_s
      else
        self.request.file.data.size
      end
    end

    def content_range
      "bytes #{self.request.lower_bound}-#{self.request.upper_bound - 1}/#{self.request.file.data.size}"
    end

    def accept_ranges
      'bytes'
    end

    def cache_control
      'no-cache'
    end

  end
end