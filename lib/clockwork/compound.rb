module Clockwork
  class Compound < Expression
    def initialize(left, right)
      @expressions = left, right
    end
    
    def attributes
      @expressions.map { |e| e.attributes }.flatten
    end
  end # class Compound
  
  class Union < Compound
    def |(expression)
      @expressions << expression
      self
    end
    
    def ===(other)
      @expressions.any? { |e| e === other }
    end
  end # class Union
  
  class Intersection < Compound
    def &(expression)
      @expressions << expression
      self
    end
    
    def ===(other)
      @expressions.all? { |e| e === other }
    end
  end # class Intersection
  
  class Difference < Compound
    def initialize(left, right)
      @positive = left
      @negatives = Array(right)
      @expressions = [@positive, *@negatives]
    end
    
    def -(expression)
      @negatives << expression
      @expressions << expression
      self
    end
    
    def ===(other)
      @positive === other and not @negatives.any? { |e| e === other }
    end
  end # class Difference
end # module Clockwork
