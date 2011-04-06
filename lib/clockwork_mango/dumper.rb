require "clockwork_mango/predicate"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  module Dumper
    extend self

    def dump(predicate)
      dumper = dumper_for_predicate(predicate)
      dumper.dump(predicate)
    end

    def dumper_for_predicate(predicate)
      Dumper.mapping.detect { |(k,d)| k === predicate }.try(:last) or
        fail(ArgumentError, "expected one of #{Dumper.mapping.map { |m| m[0] }.join(', ')}")
    end

    module Comparison
      extend self
      def dump(predicate)
        [predicate.operator, predicate.attribute, predicate.value]
      end
    end # module Comparison

    module Compound
      extend self
      def dump(predicate)
        [predicate.operator] + predicate.predicates.map { |p| p.to_temporal_sexp }
      end
    end # module Compound

    module Offset
      extend Compound
      extend self
      def dump(predicate)
        super + [predicate.unit, predicate.value]
      end
    end # module Offset

    def self.mapping
      [
        [Predicate::Offset,     Dumper::Offset],
        [Predicate::Compound,   Dumper::Compound],
        [Predicate::Comparison, Dumper::Comparison],
      ]
    end

  end # module Dumper
end # module ClockworkMango
