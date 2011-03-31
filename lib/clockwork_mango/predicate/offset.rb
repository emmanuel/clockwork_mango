# require 'active_support/core_ext/string/inflections'  # see #L14
require 'clockwork_mango/predicate/compound'

module ClockworkMango
  module Predicate
    class Offset < Compound
      @operator = :>>

      def initialize(predicate, unit, value)
        unless predicate.is_a?(Predicate)
          raise ArgumentError, "expected a Predicate, got: #{predicate.inspect}"
        end
        @predicate = predicate
        # @unit      = unit.to_s.pluralize.to_sym   # why not :day => :days?
        @unit      = /s$/ =~ unit.to_s ? unit.to_sym : :"#{unit}s"
        @value     = value
      end

      def predicates
        [@predicate]
      end

      def ===(other)
        if other.respond_to?(:advance) and @predicate === other.advance(@unit => -@value)
          other
        else
          false
        end
      end

    end # class Offset
  end # module Predicate
end # module ClockworkMango
