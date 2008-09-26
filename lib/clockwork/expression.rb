module Clockwork
  class Expression
    def ===(other)
      raise NoMethodError, "subclasses must define #==="
    end
    
    def attributes
      raise NoMethodError, "subclasses must define #attributes"
    end
    
    def &(expression)
      Intersection.new(self, expression)
    end
    
    def |(expression)
      Union.new(self, expression)
    end
    
    def -(expression)
      Difference.new(self, expression)
    end
  end
end
