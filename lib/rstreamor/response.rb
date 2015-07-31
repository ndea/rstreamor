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
        ranges = self.request.ranges
        (ranges[1].to_i - ranges[0].to_i + 1).to_s
      else
        self.request.file.data.size
      end
    end

    def content_range
      ranges = self.request.ranges
      "bytes #{ranges[0]}-#{ranges[1]}/#{self.request.file.data.size}"
    end

    def accept_ranges
      'bytes'
    end

    def cache_control
      'no-cache'
    end

  end
end