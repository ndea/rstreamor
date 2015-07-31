module Rstreamor
  class File

    def initialize(file)
      self.file = file
    end

    def data
      self.file.data
    end

    def content_type
      self.file.content_type
    end

    def size
      data.size
    end

  end
end