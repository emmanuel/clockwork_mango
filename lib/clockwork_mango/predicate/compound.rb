require 'clockwork_mango/predicate/base'

module ClockworkMango
  module Predicate
    class Compound < Base
      attr_reader :predicates

      def initialize(*predicates)
        @predicates = predicates
      end

      def attributes
        predicates.map { |p| p.attributes }.flatten
      end

      def values
        predicates.map { |p| p.values }.flatten
      end

      def to_temporal_sexp
        [operator] + predicates.map { |p| p.to_temporal_sexp }
      end

      # FIXME: implement #next_occurrence_after for Predicate::Compound and subclasses
      def next_occurrence_after(after)
        raise NotImplementedError, "Predicate::Compound::Base#next_occurrence_after not implemented"
      end

    end # class Compound
  end # module Predicate
end # module ClockworkMango

require "clockwork_mango/predicate/difference"
require "clockwork_mango/predicate/intersection"
require "clockwork_mango/predicate/offset"
require "clockwork_mango/predicate/union"
