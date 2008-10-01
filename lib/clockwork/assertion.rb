module Clockwork
  ASSERTABLE_ATTRIBUTES = [:year, :month, :mday, :hour, :min, :sec, :usec,
    :yday, :yweek, :mweek, :wday, :wday_in_month]
  
  class Assertion < Expression
    attr_reader :attribute, :value, :reverse
    attr_reader *ASSERTABLE_ATTRIBUTES

    def initialize(attribute, value)
      @reverse = false
      case value
      when Integer
        @reverse = true if value < 0
      when Range
        # how to gracefully allow ranges to wrap around?
        @reverse = true if value.begin < 0 and value.end < 0
      end
      attribute = @reverse ? "#{attribute}_reverse" : attribute
      @attribute, @value = attribute.to_sym, value
      instance_variable_set("@#{@attribute}", @value)
    end
    
    def attributes
      [@attribute]
    end
    
    def values
      [@value]
    end
    
    def ===(other)
      rval = other.send(@attribute) rescue false
      @value === rval or rval.nil?
    end
  end
end
