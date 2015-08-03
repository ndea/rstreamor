module Rstreamor
  module Stream
    def stream(file)
      request_builder = Rstreamor::Request.new(request, Rstreamor::File.new(file))
      response_builder = Rstreamor::Response.new(request_builder)
      set_response_header(request_builder, response_builder)
      stream_file(request_builder, response_builder)
    end

    private

    def stream_file(request_builder, response_builder)
      content = request_builder.slice_file
      send_data content, type: request_builder.file_content_type, disposition: 'inline', status: response_builder.response_code
    end

    def set_response_header(request_builder, response_builder)
      response.headers['Content-Type'] = request_builder.file_content_type
      response.headers['Content-Length'] = response_builder.content_length
      if request_builder.range_header?
        response.headers['Accept-Ranges'] = 'bytes'
        response.headers['Cache-Control'] = 'no-cache'
        response.headers['Content-Range'] = response_builder.content_range
      end
    end
  end
end