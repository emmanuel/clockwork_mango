require 'clockwork_mango/predicate/compound'

module ClockworkMango
  module Predicate
    class Union < Compound
      @operator = :|

      def |(predicate)
        if predicate.is_a?(Predicate)
          Predicate::Union.new(*(self.predicates + [predicate]))
        else
          predicate
        end
      end

      def ===(other)
        predicates.any? { |p| p === other }
      end

      def next_occurrence_after(after)
        candidates = predicates.map { |p| p.next_occurrence_after(after) }
        candidates.reject! { |t| after == t }
        candidates.min
      end

    end # class Union
  end # module Predicate
end # module ClockworkMango
