require 'active_support/core_ext/string/inflections'
require 'clockwork_mango/predicate'

module ClockworkMango
  class CompoundPredicate < Predicate
    attr_reader :predicates

    def initialize(*predicates)
      @predicates = predicates
    end

    def attributes
      self.predicates.map { |p| p.attributes }.flatten
    end

    def values
      self.predicates.map { |p| p.values }.flatten
    end

    def to_temporal_expression
      [operator] + self.predicates.map { |p| p.to_temporal_expression }
    end

    # FIXME: implement #next_occurrence_after for CompoundPredicate and subclasses
    def next_occurrence_after(after)
      raise NotImplementedError, "CompoundPredicate#next_occurrence_after not implemented"
    end

  end # class CompoundPredicate

  class UnionPredicate < CompoundPredicate
    @operator = :|

    def |(predicate)
      if predicate.is_a?(Predicate)
        UnionPredicate.new(*(self.predicates + [predicate]))
      else
        predicate
      end
    end

    def ===(other)
      self.predicates.any? { |p| p === other }
    end

  end # class UnionPredicate

  class IntersectionPredicate < CompoundPredicate
    @operator = :&

    def &(predicate)
      if predicate.is_a?(Predicate)
        IntersectionPredicate.new(*(self.predicates + [predicate]))
      else
        predicate
      end
    end

    def ===(other)
      self.predicates.all? { |p| p === other }
    end

  end # class IntersectionPredicate

  class DifferencePredicate < CompoundPredicate
    @operator = :-

    def initialize(positive, *negatives)
      @positive = positive
      @negatives = negatives
      @predicates = [positive] + negatives
    end

    def -(predicate)
      if predicate.is_a?(Predicate)
        DifferencePredicate.new(@positive, *(@negatives + [predicate]))
      else
        predicate
      end
    end

    def ===(other)
      @positive === other and not @negatives.any? { |p| p === other }
    end

  end # class DifferencePredicate

  class OffsetPredicate < CompoundPredicate
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

    def to_temporal_expression
      super + [@unit, @value]
    end

  end # class OffsetPredicate

end # module ClockworkMango
