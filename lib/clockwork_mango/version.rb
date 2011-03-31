module ClockworkMango
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 2
    TINY = 0

    def self.to_s
      [MAJOR, MINOR, TINY].join('.')
    end
  end # module VERSION
end # module ClockworkMango
