module ClockworkMango
  class CompoundPredicate < Predicate
    def initialize(left, right)
      @predicates = [left, right]
    end

    def attributes
      @predicates.map { |p| p.attributes }.flatten
    end

    def values
      @predicates.map { |p| p.values }.flatten
    end

    def to_sexp
      [operator, *@predicates.map { |p| p.to_sexp }]
    end

    # FIXME: implement #next_occurrence_after for CompoundPredicate and subclasses
    def next_occurrence_after(after)
      raise NotImplementedError, "CompoundPredicate#next_occurrence_after not implemented"
    end

  end # class CompoundPredicate

  class UnionPredicate < CompoundPredicate
    def |(predicate)
      unless predicate.nil?
        @predicates << predicate
      end
      self
    end

    def ===(other)
      @predicates.any? { |p| p === other }
    end

    def operator
      :|
    end

  end # class UnionPredicate

  class IntersectionPredicate < CompoundPredicate
    def &(predicate)
      unless predicate.nil?
        @predicates << predicate
      end
      self
    end

    def ===(other)
      @predicates.all? { |p| p === other }
    end

    def operator
      :&
    end

  end # class IntersectionPredicate

  class DifferencePredicate < CompoundPredicate
    def initialize(left, right)
      @positive = left
      @negatives = Array(right)
      @predicates = [@positive, *@negatives]
    end

    def -(predicate)
      unless predicate.nil?
        @negatives << predicate
        @predicates << predicate
      end
      self
    end

    def ===(other)
      @positive === other and not @negatives.any? { |p| p === other }
    end

    def operator
      :-
    end

  end # class DifferencePredicate

end # module ClockworkMango
