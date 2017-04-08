module Response
  # Base Response Service
  # - Parent of Success and Error
  class Base
    attr_reader :data

    def initialize(data)
      @data = data
    end
  end
end
