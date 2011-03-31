require "clockwork_mango/predicate/base"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  module Predicate
    module Dumper
      def self.dump(predicate)
        dumper = MAPPING.detect { |(k,d)| k === predicate }.try(:last)
        dumper or fail(ArgumentError, "expected Comparison, or Compound Predicate")
        dumper.dump(predicate)
      end

      module Comparison
        def self.dump(predicate)
          [predicate.operator, predicate.attribute, predicate.value]
        end
      end # module Comparison

      module Compound
        def self.dump(predicate)
          [predicate.operator] + predicate.predicates.map { |p| p.to_temporal_sexp }
        end
      end # module Compound

      module Offset
        def self.dump(predicate)
          Compound.dump(predicate) + [predicate.unit, predicate.value]
        end
      end # module Offset

      MAPPING = [
        [Predicate::Comparison, Dumper::Comparison],
        [Predicate::Compound,   Dumper::Compound],
        [Predicate::Offset,     Dumper::Offset],
      ]

    end # module Dumper
  end # module Predicate
end # module ClockworkMango
