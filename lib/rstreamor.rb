require 'rstreamor/version'
require 'rstreamor/file'
require 'rstreamor/request'
require 'rstreamor/response'
module Rstreamor

  def stream(file)
    request_builder = Rstreamor::Request.new(request, file)
    response_builder = Rstreamor::Response.new(request_builder)
    stream_file(request_builder, response_builder)
  end

  private

  def stream_file
    content = request_builder.slice_file
    send_data @content, type: @file.content_type, disposition: 'inline', status: @response_code
  end

end
