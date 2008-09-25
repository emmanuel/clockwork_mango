module Clockwork
  class Expression
    def attributes
      []
    end

    def ===(other)
      raise NoMethodError, "subclasses must define '==='"
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
