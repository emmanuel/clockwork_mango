require 'clockwork_mango/predicate'

module ClockworkMango
  module Predicate
    class Compound
      include Predicate
      attr_reader :predicates

      def initialize(*predicates)
        @predicates = predicates
      end

      def attributes
        predicates.map { |p| p.attributes }.flatten
      end

      # FIXME: this just isn't going to cut it.
      # TODO: maybe a full tree here?
      def values
        predicates.map { |p| p.values }.flatten
      end

    end # class Compound
  end # module Predicate
end # module ClockworkMango

require "clockwork_mango/predicate/difference"
require "clockwork_mango/predicate/intersection"
require "clockwork_mango/predicate/offset"
require "clockwork_mango/predicate/union"
