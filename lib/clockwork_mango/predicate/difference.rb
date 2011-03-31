require 'clockwork_mango/predicate/compound'

module ClockworkMango
  module Predicate
    class Difference < Compound
      @operator = :-

      def initialize(positive, *negatives)
        @positive = positive
        @negatives = negatives
        @predicates = [positive] + negatives
      end

      def -(predicate)
        if predicate.is_a?(Predicate)
          Predicate::Difference.new(@positive, *(@negatives + [predicate]))
        else
          predicate
        end
      end

      def ===(other)
        @positive === other and not @negatives.any? { |p| p === other }
      end

    end # class Difference
  end # module Predicate
end # module ClockworkMango
