require "enumerator"

module Clockwork
  ASSERTABLE_ATTRIBUTES = [:year, :month, :mday, :hour, :min, :sec, :usec,
    :yday, :yweek, :mweek, :wday, :wday_in_month]
  
  REVERSIBLE_ATTRIBUTES = [:month, :mday, :hour, :min, :sec, :usec,
    :yday, :yweek, :mweek, :wday, :wday_in_month]
  
  ATTR_RECURRENCE_SCOPE = {
    :year  => nil,
    :month => :year,
    :mday  => :month,
    :hour  => :day,
    :min   => :hour,
    :sec   => :min,
    :usec  => :sec,
    
    :yday  => :year,
    :yweek => :year,
    :mweek => :month,
    :wday  => :yweek,
    :wday_in_month => :month,
  }
  
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
    
    def next_occurrence(after = Time.now)
      next_occurrences(1, after).first
    end
    
    def next_occurrences(limit = 1, after = Time.now)
      recurrence_unit = ATTR_RECURRENCE_SCOPE[@attribute]
      if recurrence_unit
        Array(1..limit).map do |n|
          a = {
            :year  => after.year,
            :month => after.month,
            :mday  => after.mday,
            :hour  => after.hour,
            :min   => after.min,
            :sec   => after.sec,
          }.merge(@attribute => @value)
          occurrence = Time.local(a[:year], a[:month], a[:mday], a[:hour], a[:min], a[:sec])
          after < occurrence ? occurrence :
            occurrence + after.class.unit_value(recurrence_unit, 1)
        end
      else
        []
      end
    end
    
    def operator
      :===
    end
    
    def to_sexp
      [operator, @attribute, @value]
    end
  end
end
