# ClockworkMango::Predicate::Comparison (abstract)
# and all subclasses (concrete) are defined in this file
require "clockwork_mango/core_ext"
require "clockwork_mango/predicate/base"
require "clockwork_mango/constants"

module ClockworkMango
  module Predicate
    class Comparison < Base
      include Constants

      @operator = :===

      attr_reader :attribute, :value, :reverse
      attr_reader *COMPARABLE_ATTRIBUTES

      def initialize(attribute, value)
        unless value.respond_to?(operator)
          raise ArgumentError, "expected value to respond to :#{operator}"
        end

        @reverse = false
        case value
        when Integer
          @reverse = true if value < 0
        when Range
          # TODO: allow ranges to wrap around gracefully
          @reverse = true if value.begin < 0 and value.end < 0
        end
        attribute = @reverse ? "#{attribute}_reverse" : attribute
        @attribute, @value = attribute.to_sym, value
        instance_variable_set("@#{@attribute}", @value)
      end

      def attributes
        [@attribute]
      end

      def values
        [@value]
      end

      def ===(other)
        rval = other.send(@attribute) rescue false
        compare(rval)
      end

      # nil passes any comparison by default. this is to allow less precise
      # temporal objects to match all more precise predicates.
      # In other words, Dates match all hour, min, sec and usec predicates
      # and DateTimes match all usec predicates
      def compare(other)
        other.nil? or @value.send(operator, other)
      end

      def next_occurrence_after(after)
        if recurrence_unit = ATTR_RECURRENCE[@attribute]
          reset_primacy = ATTR_RESET[@attribute]
          reset_index = ATTR_PRIMACY.index(reset_primacy) || 0
          updated_attr = { @attribute => @value }
          ATTR_PRIMACY.each_with_index do |attr, i|
            updated_attr[attr] = ATTR_RESET_VALUES[attr] if i <= reset_index
          end
          occurrence = after.change(updated_attr)
          if @attribute == :year and @value < after.year
            nil
          elsif after < occurrence
            occurrence
          else
            begin
              occurrence = occurrence.advance(recurrence_unit => 1)
            end until self === occurrence
            occurrence
          end
        else
          nil
        end
      end

      def next_occurrences(limit = 1, after = Time.now.utc)
        Array(1..limit).map do |i|
          next_occurrence(after.advance(ATTR_RECURRENCE[@attribute] => i))
        end
      end

      def self.predicate_for(operator)
        Class.new(self) { @operator = operator }
      end

    end

    # Subclasses
    Inclusion          = Comparison.predicate_for(:include?)
    Exclusion          = Comparison.predicate_for(:exclude?)
    Equality           = Comparison.predicate_for(:==)
    GreaterThan        = Comparison.predicate_for(:>)
    GreaterThanOrEqual = Comparison.predicate_for(:>=)
    LessThan           = Comparison.predicate_for(:<)
    LessThanOrEqual    = Comparison.predicate_for(:<=)

  end
end
