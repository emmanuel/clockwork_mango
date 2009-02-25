require "enumerator"

module Clockwork
  ASSERTABLE_ATTRIBUTES = [:year, :month, :day, :hour, :min, :sec, :usec,
    :yday, :yweek, :mweek, :wday, :wday_in_month]
  
  REVERSIBLE_ATTRIBUTES = [:month, :day, :hour, :min, :sec, :usec,
    :yday, :yweek, :mweek, :wday, :wday_in_month]
  
  ATTR_RECURRENCE = {
    :year  => nil,
    :month => :years,
    :day   => :months,
    :hour  => :days,
    :min   => :hours,
    :sec   => :minutes,
    :usec  => :seconds,
              
    :yday  => :years,
    :yweek => :years,
    :mweek => :months,
    :wday  => :weeks,
    :wday_in_month => :months,
  }
  ATTR_RESET = {
    :year  => :hour,
    :month => :hour,
    :day   => :hour,
    :hour  => :min,
    :min   => :sec,
    :sec   => :usec,
    :usec  => nil,
              
    :yday  => :hour,
    :yweek => :hour,
    :mweek => :hour,
    :wday  => :hour,
    :wday_in_month => :hour,
  }
  ATTR_PRIMACY = [:usec, :sec, :min, :hour, :day]
  
  class Assertion < Expression
    attr_reader :attribute, :value, :reverse
    attr_reader *ASSERTABLE_ATTRIBUTES

    def initialize(attribute, value)
      @reverse = false
      case value
      when Integer
        @reverse = true if value < 0
      when Range
        # TODO: allow ranges to wrap around gracefully
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
    
    def next_occurrence(after = Time.now.utc)
      if recurrence_unit = ATTR_RECURRENCE[@attribute] # rescue nil
        reset_index = ATTR_PRIMACY.index(ATTR_RESET[@attribute]).to_i # convert nil to 0
        updated_attr = { @attribute => @value }
        ATTR_PRIMACY.each_with_index do |attr, i|
          updated_attr[attr] = 0 if i <= reset_index
        end
        occurrence = after.change(updated_attr)
        if after < occurrence
          occurrence
        else
          begin
            occurrence = occurrence.advance(recurrence_unit => 1)
          end until self === occurrence
          occurrence
        end
      else
        nil
      end
    end
    
    def next_occurrences(limit = 1, after = Time.now.utc)
      Array(1..limit).map do |i|
        next_occurrence(after.advance(ATTR_RECURRENCE[@attribute] => i))
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
