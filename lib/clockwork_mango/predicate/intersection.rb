require 'clockwork_mango/predicate/compound'

module ClockworkMango
  module Predicate
    class Intersection < Compound
      @operator = :&

      def &(predicate)
        if predicate.is_a?(Predicate)
          Predicate::Intersection.new(*(self.predicates + [predicate]))
        else
          predicate
        end
      end

      def ===(other)
        self.predicates.all? { |p| p === other }
      end

    end # class IntersectionPredicate
  end # module Predicate
end # module ClockworkMango
