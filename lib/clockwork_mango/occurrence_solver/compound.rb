require "clockwork_mango/occurrence_solver"

module ClockworkMango
  module OccurrenceSolver
    # TODO: is this intermediate abstract superclass going to be useful?
    class Compound < OccurrenceSolver::Base
    end

    class Union < Compound
      def next_occurrence(after = Time.now.utc)
        candidates = @predicate.predicates.map { |p| p.next_occurrence(after) }
        candidates.reject! { |t| after == t }
        candidates.min
      end
    end

    class Intersection < Compound
      # FIXME: implement #next_occurrence for Intersection
      def next_occurrence(after = Time.now.utc)
        # something magical happens here!
      end
    end

    class Difference < Compound
      # TODO: test this!
      # TODO: this is just brute force right now, and might not even be correct
      def next_occurrence(after = Time.now.utc)
        positive = predicate.predicates.first
        occurrence = after
        occurrence = positive.next_occurrence(occurrence) until predicate === occurrence
        occurrence
      end
    end

    class Offset < Compound
      # TODO: test this!
      def next_occurrence(after = Time.now.utc)
        predicate.offset(predicate.predicate.next_occurrence(after))
      end
    end

  end
end