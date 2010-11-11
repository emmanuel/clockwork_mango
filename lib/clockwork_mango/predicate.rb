module ClockworkMango
  class Predicate
    # Get the operator of this Predicate
    def operator
      nil
    end

    # Get a representation of this Predicate as an s-expression
    # 
    # @return [Array(Symbol, Symbol, Object)]
    #   typically [operator, attribute, value]
    def to_temporal_expression
      []
    end

    def ==(other)
      other if other.respond_to?(:to_temporal_expression) and
        self.to_temporal_expression == other.to_temporal_expression
    end

    def inspect
      "<#{self.class}:#{object_id.to_s(16)} temporal_expression=#{to_temporal_expression.inspect}>"
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
    # @param [ClockworkMango::Predicate] predicate
    #   the Predicate to intersect with +self+
    # 
    # @return [ClockworkMango::IntersectionPredicate]
    #   the intersection of +self+ and +predicate+
    def &(predicate)
      predicate.is_a?(Predicate) ? IntersectionPredicate.new(self, predicate) : self
    end

    # Union self with another Predicate. The returned UnionPredicate will
    # match if either self or predicate matches.
    # 
    # @param [ClockworkMango::Predicate] predicate
    #   the Predicate to union with +self+
    # 
    # @return [ClockworkMango::UnionPredicate]
    #   the union of +self+ and +predicate+
    def |(predicate)
      predicate.is_a?(Predicate) ? UnionPredicate.new(self, predicate) : self
    end

    # Subtract an Predicate from this one. The returned DifferencePredicate will
    # match if +self+ matches and +predicate+ does not.
    # 
    # @param [ClockworkMango::Predicate] predicate
    #   the Predicate to subtract from +self+
    # 
    # @return [ClockworkMango::DifferencePredicate]
    #   the difference of +self+ and +predicate+
    def -(predicate)
      predicate.is_a?(Predicate) ? DifferencePredicate.new(self, predicate) : self
    end

    # Gets the next occurrence of this predicate after +after+, if it recurs
    # after then.
    def next_occurrence_after(after)
      nil
    end

  end
end
