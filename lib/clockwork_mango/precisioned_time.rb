require "forwardable"
require "clockwork_mango/predicate"
# require "clockwork_mango/dsl"

module ClockworkMango
  class PrecisionedTime
    extend Forwardable
    include Predicate

    def_delegators :@predicate, *Predicate.public_instance_methods

    attr_reader :year, :month, :mday

    def initialize(year, month = nil, mday = nil, hour = nil, min = nil, sec = nil)
      @predicate = Predicate::Equality.year(year)
      @predicate &= Predicate::Equality.month(month) if month
      @predicate &= Predicate::Equality.mday(mday)   if mday
      @predicate &= Predicate::Equality.hour(hour)   if hour
      @predicate &= Predicate::Equality.min(min)     if min
      @predicate &= Predicate::Equality.sec(sec)     if sec
    end
  end # class PrecisionedTime
end # module ClockworkMango
