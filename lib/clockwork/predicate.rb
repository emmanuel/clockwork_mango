module Clockwork
  class Predicate
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

    # Test matchiness of "other" in "self". Subclasses should override this
    # method to provide meaningful match semantics (eg., ComparisonPredicate#===).
    # 
    # @param [Object] other
    #   an Object to be tested against this predicate
    # 
    # @return [TrueClass, FalseClass]
    #   does +self+ include +other+?
    def ===(other)
      false
    end

    # Intersect self with another Predicate. The returned IntersectionPredicate
    # will only match if self and predicate match.
    # 
    # @param [Clockwork::Predicate] predicate
    #   the Predicate to intersect with +self+
    # 
    # @return [Clockwork::IntersectionPredicate]
    #   the intersection of +self+ and +predicate+
    def &(predicate)
      predicate.nil? ? self : IntersectionPredicate.new(self, predicate)
    end

    # Union self with another Predicate. The returned UnionPredicate will
    # match if either self or predicate matches.
    # 
    # @param [Clockwork::Predicate] predicate
    #   the Predicate to union with +self+
    # 
    # @return [Clockwork::UnionPredicate]
    #   the union of +self+ and +predicate+
    def |(predicate)
      predicate.nil? ? self : UnionPredicate.new(self, predicate)
    end

    # Subtract an Predicate from this one. The returned DifferencePredicate will
    # match if +self+ matches and +predicate+ does not.
    # 
    # @param [Clockwork::Predicate] predicate
    #   the Predicate to subtract from +self+
    # 
    # @return [Clockwork::DifferencePredicate]
    #   the difference of +self+ and +predicate+
    def -(predicate)
      predicate.nil? ? self : DifferencePredicate.new(self, predicate)
    end

    # Gets the next +limit+ occurrences of this predicate, if it recurs that
    # many times.
    def next_occurrence(after = Time.now.utc)
      nil
    end

    # Get the operator of this Predicate
    def operator
      nil
    end

    # Get a representation of this Predicate as an s-expression
    def to_sexp
      [operator]
    end

  end
end
