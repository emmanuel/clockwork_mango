module Clockwork
  class Expression
    # Disclose which attributes this Expression is concerned with
    # 
    # @return [Array(Symbol)]
    #   attribute names asserted in this expression
    def attributes
      []
    end
    
    # Disclose which values this Expression is concerned with
    # 
    # @return [Array(Integer, Range)]
    #   attribute values asserted in this expression
    def values
      []
    end
    
    # Test matchiness of "other" in "self". Subclasses should override this
    # method to provide meaningful match semantics (eg., Assertion#===).
    # 
    # @param [Object] other
    #   an Object to be tested against this expression
    # 
    # @return [TrueClass, FalseClass]
    #   does +self+ include +other+?
    def ===(other)
      false
    end
    
    # Intersect self with another Expression. The returned Intersection will
    # only match if self and expression match.
    # 
    # @param [Clockwork::Expression] expression
    #   the Expression to intersect with +self+
    # 
    # @return [Clockwork::Intersection]
    #   the Intersection of +self+ and +expression+
    def &(expression)
      expression.nil? ? self : Intersection.new(self, expression)
    end
    
    # Union self with another Expression. The returned Union will
    # match if either self or expression matches.
    # 
    # @param [Clockwork::Expression] expression
    #   the Expression to union with +self+
    # 
    # @return [Clockwork::Union]
    #   the Union of +self+ and +expression+
    def |(expression)
      expression.nil? ? self : Union.new(self, expression)
    end
    
    # Subtract an Expression from this one. The returned Difference will
    # match if +self+ matches and +expression+ does not.
    # 
    # @param [Clockwork::Expression] expression
    #   the Expression to subtract from +self+
    # 
    # @return [Clockwork::Difference]
    #   the Difference of +self+ and +expression+
    def -(expression)
      expression.nil? ? self : Difference.new(self, expression)
    end
    
    # Gets the next +limit+ occurrences of this expression, if it recurs that
    # many times.
    def next_occurrence(after = Time.now.utc)
      nil
    end
    
    # Get the operator of this Expression
    def operator
      nil
    end
    
    # Get a representation of this Expression as an s-expression
    def to_sexp
      [operator]
    end
  end
end
