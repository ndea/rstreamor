module Rstreamor
  class File
    attr_accessor :file

    def initialize(file)
      self.file = file
    end

    def data
      if self.file.respond_to? :data
        self.file.data
      else
        self.file.read
      end
    end

    def content_type
      self.file.content_type
    end

    def size
      data.size
    end

  end
end