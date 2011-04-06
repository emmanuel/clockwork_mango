# requires at end
module ClockworkMango
  module Predicate
    def self.included(base)
      class << base
        attr_reader :operator
      end
    end

    # Get the operator of this Predicate
    def operator
      self.class.operator
    end

    def ==(other)
      other.respond_to?(:to_temporal_sexp) and
        self.to_temporal_sexp == other.to_temporal_sexp
    end

    # Test whether +self+ matches +other+.
    # Subclasses should override to provide meaningful match semantics, ex:
    #   Predicate::Comparison#===
    # 
    # @param [Object] other
    #   an Object to be tested against this predicate
    # 
    # @return [TrueClass, FalseClass]
    #   does +self+ include +other+?
    def ===(other)
      false
    end

    # Disclose which attributes this Predicate is concerned with
    # 
    # @return [Array(Symbol)]
    #   attribute names asserted in this predicate
    def attributes
      []
    end

    # Disclose which values this Predicate is concerned with
    # 
    # @return [Array(Integer, Range)]
    #   attribute values asserted in this predicate
    def values
      []
    end

    # Intersect self with another Predicate. The returned Predicate::Intersection
    # will only match if self and predicate match.
    # 
    # @param [ClockworkMango::Predicate] predicate
    #   the Predicate to intersect with +self+
    # 
    # @return [ClockworkMango::Predicate::Intersection]
    #   the intersection of +self+ and +predicate+
    def &(predicate)
      predicate.is_a?(Predicate) ? Predicate::Intersection.new(self, predicate) : self
    end

    # Union self with another Predicate. The returned Predicate::Union will
    # match if either self or predicate matches.
    # 
    # @param [ClockworkMango::Predicate] predicate
    #   the Predicate to union with +self+
    # 
    # @return [ClockworkMango::Predicate::Union]
    #   the union of +self+ and +predicate+
    def |(predicate)
      predicate.is_a?(Predicate) ? Predicate::Union.new(self, predicate) : self
    end

    # Subtract an Predicate from this one. The returned Predicate::Difference
    # will match if +self+ matches and +predicate+ does not.
    # 
    # @param [ClockworkMango::Predicate] predicate
    #   the Predicate to subtract from +self+
    # 
    # @return [ClockworkMango::Predicate::Difference]
    #   the difference of +self+ and +predicate+
    def -(predicate)
      predicate.is_a?(Predicate) ? Predicate::Difference.new(self, predicate) : self
    end

    # Offset from this predicate
    # 
    # @param [Array(Symbol, Numeric)] unit_value
    #   the unit and value to offset from +self+
    # 
    # @return [ClockworkMango::Predicate::Offset]
    #   the offset of +self+ and +unit_value+
    def >>(unit_value)
      unit, value = unit_value
      raise ArgumentError, "expected two-element array" unless unit && value
      Predicate::Offset.new(self, unit, value)
    end

    def inspect
      "<#{self.class}:#{object_id.to_s(16)} expression=#{to_temporal_sexp.inspect}>"
    end

    # Get the next occurrence of this predicate after +after+, if it recurs
    # after then.
    def next_occurrence(after = Time.now.utc)
      occurrence_solver.next_occurrence(after)
    end

    # Get the next +limit+ occurrences of this predicate after +after+,
    # if it recurs +limit+ times following +after+.
    def next_occurrences(limit = 1, after = Time.now.utc)
      occurrence_solver.next_occurrences(limit, after)
    end

    def occurrence_solver
      OccurrenceSolver.for(self)
    end

    # Get a representation of this Predicate as an s-expression
    # 
    # @return [Array(Symbol, Symbol, Object)]
    #   typically [operator, attribute, value]
    def to_temporal_sexp
      Dumper.dump(self)
    end

  end # module Predicate
end # module ClockworkMango

require "clockwork_mango/predicate/compound"
require "clockwork_mango/occurrence_solver"
require "clockwork_mango/dumper"
