# ClockworkMango::Predicate::Comparison (abstract),
# and all subclasses (concrete) are defined in this file
require "clockwork_mango/core_ext"
require "clockwork_mango/predicate"
require "clockwork_mango/constants"

module ClockworkMango
  module Predicate
    class Comparison
      include Predicate
      include Constants

      @operator = :===

      attr_reader :attribute, :value, :reverse

      def initialize(attribute, value)
        unless value.respond_to?(operator)
          raise ArgumentError, "expected value to respond to :#{operator}"
        end

        @reverse =
          case value
          when Integer  ; value < 0
          # TODO: allow ranges to wrap around gracefully
          when Range    ; value.begin < 0 and value.end < 0
          else            false
          end
        attribute  = @reverse ? "#{attribute}_reverse" : attribute
        @attribute = attribute.to_sym
        @value     = value
        instance_variable_set("@#{@attribute}", @value)
      end

      # adds constructors like .year, .wday, etc. which predicate the given attribute
      PREDICABLE_ATTRIBUTES.each do |attribute|
        module_eval <<-RUBY, __FILE__, __LINE__
          def #{attribute}(value)
            new(:#{attribute}, value)
          end
        RUBY
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

      def self.predicate_for(operator)
        Class.new(self) { @operator = operator }
      end
    end # class Comparison

    # Subclasses
    Inclusion          = Comparison.predicate_for(:include?)
    Exclusion          = Comparison.predicate_for(:exclude?)
    Equality           = Comparison.predicate_for(:==)
    GreaterThan        = Comparison.predicate_for(:>)
    GreaterThanOrEqual = Comparison.predicate_for(:>=)
    LessThan           = Comparison.predicate_for(:<)
    LessThanOrEqual    = Comparison.predicate_for(:<=)

  end # module Predicate
end # module ClockworkMango
