module Clockwork
  class Compound < Expression
    def initialize(left, right)
      @expressions = [left, right]
    end
    
    def attributes
      @expressions.map { |e| e.attributes }.flatten
    end
    
    def values
      @expressions.map { |e| e.values }.flatten
    end
    
    def to_sexp
      [operator, *@expressions.map { |e| e.to_sexp }]
    end
  end # class Compound
  
  class Union < Compound
    def |(expression)
      unless expression.nil?
        @expressions << expression
      end
      self
    end
    
    def ===(other)
      @expressions.any? { |e| e === other }
    end
    
    def operator
      :|
    end
  end # class Union
  
  class Intersection < Compound
    def &(expression)
      unless expression.nil?
        @expressions << expression
      end
      self
    end
    
    def ===(other)
      @expressions.all? { |e| e === other }
    end
    
    def operator
      :&
    end
  end # class Intersection
  
  class Difference < Compound
    def initialize(left, right)
      @positive = left
      @negatives = Array(right)
      @expressions = [@positive, *@negatives]
    end
    
    def -(expression)
      unless expression.nil?
        @negatives << expression
        @expressions << expression
      end
      self
    end
    
    def ===(other)
      @positive === other and not @negatives.any? { |e| e === other }
    end
    
    def operator
      :-
    end
  end # class Difference
end # module Clockwork
