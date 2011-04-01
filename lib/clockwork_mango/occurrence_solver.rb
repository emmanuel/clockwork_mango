%w[date date_time time].each do |temporal|
  require "active_support/core_ext/#{temporal}/calculations"
end

module ClockworkMango
  module OccurrenceSolver
    extend self

    ATTR_RECURRENCE = {
      :year  => :years,
      :month => :years,
      :day   => :months,
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
      :month => :day,
      :day   => :hour,
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
      :day   => 1,
      :hour  => 0,
      :min   => 0,
      :sec   => 0,
      :usec  => 0,
    }
    ATTR_PRIMACY = [:usec, :sec, :min, :hour, :day, :month]

    def next_occurrence(predicate, after = Time.now.utc)
      solver =
        case predicate
        when Predicate::Comparison  ; Comparison
        when Predicate::Union       ; Union
        when Predicate::Intersection; Intersection
        when Predicate::Offset      ; Offset
        else raise ArgumentError, "missing occurrence solver for #{predicate.inspect}"
        end
      solver.new(predicate).next_occurrence(after)
    end

    class Base
      attr_reader :predicate

      def initialize(predicate)
        @predicate = predicate
      end

      def next_occurrence(after = Time.now.utc)
      end
    end

    class Comparison < Base
      def next_occurrence(after = Time.now.utc)
        if recurrence_unit = ATTR_RECURRENCE[predicate.attribute]
          reset_primacy = ATTR_RESET[predicate.attribute]
          reset_index = ATTR_PRIMACY.index(reset_primacy) || 0
          updated_attr = { predicate.attribute => predicate.value }
          ATTR_PRIMACY.each_with_index do |attr, i|
            updated_attr[attr] = ATTR_RESET_VALUES[attr] if i <= reset_index
          end
          occurrence = after.change(updated_attr)
          if predicate.attribute == :year and predicate.value < after.year
            nil
          elsif after < occurrence
            occurrence
          else
            begin
              occurrence = occurrence.advance(recurrence_unit => 1)
            end until predicate === occurrence
            occurrence
          end
        else
          nil
        end
      end
    end

    class Compound < Base
    end

    class Union < Compound
      def next_occurrence(after = Time.now.utc)
        candidates = predicate.predicates.map { |p| p.next_occurrence(after) }
        candidates.reject! { |t| after == t }
        candidates.min
      end
    end
  end
end