require 'rstreamor/version'
require 'rstreamor/file'
require 'rstreamor/request'
require 'rstreamor/response'
module Rstreamor

  def stream(file)
    request_builder = Rstreamor::Request.new(request, file)
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
    if request_builder.range_header?
      response.headers['Accept-Ranges'] = 'bytes'
      response.headers['Content-Length'] = (request_builder.upper_bound - request_builder.lower_bound + 1).to_s
      response.headers['Content-Range'] = "bytes #{request_builder.lower_bound}-#{request_builder.upper_bound}/#{request_builder.file_size}"
      response.headers['Cache-Control'] = 'no-cache'
    else
      response.headers['Content-Length'] = request_builder.file_size
    end
  end

end
