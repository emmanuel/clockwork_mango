require "forwardable"
require "clockwork_mango/predicate"
require "clockwork_mango/dsl"

module ClockworkMango
  module Precisioned
    class Date
      extend Forwardable
      include Predicate

      def_delegators :@predicate, *Predicate.public_instance_methods
      attr_reader :date, :predicate

      def initialize(date)
        @date = date
        @predicate = ClockworkMango::Dsl.build_predicate do
          year(date.year) & month(date.month) & mday(date.mday)
        end 
      end
    end

    class Time
      extend Forwardable
      include Predicate

      def_delegators :@predicate, *Predicate.public_instance_methods
      attr_reader :time, :predicate

      def initialize(time)
        @time = time
        @predicate = ClockworkMango::Dsl.build_predicate do
          year(time.year) & month(time.month) & mday(time.mday) &
            hour(time.hour) & min(time.min) & sec(time.sec)
        end
      end
    end

  end
end
