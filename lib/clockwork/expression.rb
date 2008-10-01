module Clockwork
  class Expression
    # Disclose which attributes this Expression is concerned with
    # 
    # @return <Array[<Symbol>]> attribute names asserted in this expression
    def attributes
      []
    end
    
    # Disclose which values this Expression is concerned with
    # 
    # @return <Array[<Integer, Range>]> attribute values asserted in this expression
    def values
      []
    end
    
    # Test matchiness of "other" in "self". Subclasses should override this
    # method to provide meaningful match semantics (eg., Assertion#===).
    # 
    # @param other<Object> an Object to be tested against this expression
    # 
    # @return <Boolean> does other<Object> match self?
    def ===(other)
      false
    end
    
    # Intersect self with another Expression. The returned Intersection will
    # only match if self and expression match.
    # 
    # @param expression<Clockwork::Expression>
    # 
    # @return <Clockwork::Intersection>
    def &(expression)
      Intersection.new(self, expression)
    end
    
    # Union self with another Expression. The returned Union will
    # match if either self or expression matches.
    # 
    # @param expression<Clockwork::Expression>
    # 
    # @return <Clockwork::Union>
    def |(expression)
      Union.new(self, expression)
    end
    
    # Subtract an Expression from this one. The returned Difference will
    # match if self matches and expression does not.
    # 
    # @param expression<Clockwork::Expression>
    # 
    # @return <Clockwork::Difference>
    def -(expression)
      Difference.new(self, expression)
    end
  end
end
