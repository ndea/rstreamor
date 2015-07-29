module Rstreamor
  class File

    def initialize(file)
      self.file = file
    end

    def data
      self.file.data
    end

  end
end