module ClockworkMango
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 1
    TINY = 2

    STRING = [MAJOR, MINOR, TINY].join('.')
  end # module VERSION

  def self.version
    VERSION::STRING
  end

end # module ClockworkMango
