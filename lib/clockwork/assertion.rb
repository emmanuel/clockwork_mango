module Clockwork
  ASSERTABLE_ATTRIBUTES = [:year, :month, :mday, :hour, :min, :sec, :usec,
    :yday, :yweek, :wday_in_month]
  
  class Assertion < Expression
    attr_reader :attribute, :value
    attr_reader *ASSERTABLE_ATTRIBUTES

    def initialize(attribute, value)
      @attribute, @value = attribute.to_sym, value
      instance_variable_set("@#{@attribute}", @value)
    end
    
    def attributes
      [@attribute]
    end
    
    def ===(other)
      rval = other.send(@attribute) rescue false
      @value === rval or rval.nil?
    end
  end
end
