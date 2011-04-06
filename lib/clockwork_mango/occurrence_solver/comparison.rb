require "clockwork_mango/occurrence_solver"

module ClockworkMango
  module OccurrenceSolver
    ATTR_RECURRENCE = {
      :year  => :years,
      :month => :years,
      :mday  => :months,
      :hour  => :days,
      :min   => :hours,
      :sec   => :minutes,
      :usec  => :seconds,

      :yday  => :years,
      :yweek => :years,
      :mweek => :months,
      :wday  => :weeks,
      :wday_in_month => :months,
    }
    ATTR_RESET = {
      :year  => :month,
      :month => :mday,
      :mday  => :hour,
      :hour  => :min,
      :min   => :sec,
      :sec   => :usec,
      :usec  => nil,

      :yday  => :hour,
      :yweek => :hour,
      :mweek => :hour,
      :wday  => :hour,
      :wday_in_month => :hour,
    }
    ATTR_RESET_VALUES = {
      :month => 1,
      :mday  => 1,
      :hour  => 0,
      :min   => 0,
      :sec   => 0,
      :usec  => 0,
    }
    ATTR_PRIMACY = [:usec, :sec, :min, :hour, :mday, :month]

    class Comparison < OccurrenceSolver::Base
      def initialize(predicate)
        super
        @attribute = predicate.attribute
        @value     = predicate.value
      end

    private

      def attribute_advance_name(attribute)
        attribute == :mday ? :day : attribute
      end

      def next_values
        Hash[ATTR_PRIMACY.enum_for(:each_with_index).map do |attribute, i|
          reset_value_for_attribute(attribute) if i <= reset_index
        end].merge(attribute_advance_name(@attribute) => @value)
      end

      # must return a hash to be used as the arg to #advance
      def recurrence
        { ATTR_RECURRENCE[@attribute] => 1 }
      end

      def reset_primacy
        ATTR_RESET[@attribute]
      end

      def reset_index
        ATTR_PRIMACY.index(reset_primacy) || 0
      end
    end

    class Equality < Comparison
      def reset_value_for_attribute(attribute)
        [attribute_advance_name(attribute), ATTR_RESET_VALUES[attribute]]
      end

      private :reset_value_for_attribute
    end

    # TODO: implement LessThan, GreaterThan, etc.

  end # module OccurrenceSolver
end # module ClockworkMango
