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
      [operator, *self.predicates.map { |p| p.to_temporal_expression }]
    end

    # FIXME: implement #next_occurrence_after for CompoundPredicate and subclasses
    def next_occurrence_after(after)
      raise NotImplementedError, "CompoundPredicate#next_occurrence_after not implemented"
    end

  end # class CompoundPredicate

  class UnionPredicate < CompoundPredicate
    def |(predicate)
      if predicate.is_a?(Predicate)
        UnionPredicate.new(*(self.predicates.dup << predicate))
      else
        predicate
      end
    end

    def ===(other)
      self.predicates.any? { |p| p === other }
    end

    def operator
      :|
    end

  end # class UnionPredicate

  class IntersectionPredicate < CompoundPredicate
    def &(predicate)
      if predicate.is_a?(Predicate)
        IntersectionPredicate.new(*(self.predicates.dup << predicate))
      else
        predicate
      end
    end

    def ===(other)
      @predicates.all? { |p| p === other }
    end

    def operator
      :&
    end

  end # class IntersectionPredicate

  class DifferencePredicate < CompoundPredicate
    def initialize(positive, *negatives)
      @positive = positive
      @negatives = negatives
      @predicates = [@positive, *@negatives]
    end

    def -(predicate)
      if predicate.is_a?(Predicate)
        DifferencePredicate.new(@positive, @negatives.dup << predicate)
      else
        self
      end
    end

    def ===(other)
      @positive === other and not @negatives.any? { |p| p === other }
    end

    def operator
      :-
    end

  end # class DifferencePredicate

end # module ClockworkMango
