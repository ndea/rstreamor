module Rstreamor
  class Response

    def initialize(request)
      self.request = request
    end

    def response_code
      self.request.range_header? ? 206 : 200
    end

  end
end