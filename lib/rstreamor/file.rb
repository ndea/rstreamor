module Rstreamor
  class File
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def data
      @data ||= if file.respond_to? :data
        file.data
      else
        file.read
      end
    end

    def content_type
      file.content_type
    end

    def size
      # Because of encoding, the string size might not match the stream size,
      # and that may lead to files being truncated when served (i.e. this happens
      # often for MP3 files, were the last few seconds of files longer than a minute
      # gets trimmed).
      @size ||= data.bytesize
    end
  end
end
