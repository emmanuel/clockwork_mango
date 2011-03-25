require "enumerator"
require "active_support/core_ext/class/attribute_accessors"
require "clockwork_mango/predicate"

module ClockworkMango
  COMPARABLE_ATTRIBUTES = [:year, :month, :day, :hour, :min, :sec, :usec,
    :yday, :yweek, :mweek, :wday, :wday_in_month]

  REVERSIBLE_ATTRIBUTES = [:month, :day, :hour, :min, :sec, :usec,
    :yday, :yweek, :mweek, :wday, :wday_in_month]

  ATTR_RECURRENCE = {
    :year  => :years,
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
    :year  => :month,
    :month => :day,
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
  ATTR_RESET_VALUES = {
    :month => 1,
    :day   => 1,
    :hour  => 0,
    :min   => 0,
    :sec   => 0,
    :usec  => 0,
  }
  ATTR_PRIMACY = [:usec, :sec, :min, :hour, :day, :month]

  VALID_ATTR_RANGES = {
    :month => -11..11,
    :day   => -30..30,
    :wday  =>  -6..6,
    :hour  => -23..23,
    :min   => -59..59,
    :sec   => -60..60,
  }
  VALID_MONTH_RANGE = VALID_ATTR_RANGES[:month]
  VALID_DAY_RANGE   = VALID_ATTR_RANGES[:day]
  VALID_WDAY_RANGE  = VALID_ATTR_RANGES[:wday]
  VALID_HOUR_RANGE  = VALID_ATTR_RANGES[:hour]
  VALID_MIN_RANGE   = VALID_ATTR_RANGES[:min]
  VALID_SEC_RANGE   = VALID_ATTR_RANGES[:sec]

  class ComparisonPredicate < Predicate
    @operator = :===

    attr_reader :attribute, :value, :reverse
    attr_reader *COMPARABLE_ATTRIBUTES

    def initialize(attribute, value)
      unless value.respond_to?(operator)
        raise ArgumentError, "expected value to respond to :#{operator}"
      end

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
      compare(rval)
    end

    # nil passes any comparison by default. this is to allow less precise
    # temporal objects to match all more precise predicates.
    # In other words, Dates match all hour, min, sec and usec predicates
    # and DateTimes match all usec predicates
    def compare(other)
      other.nil? or @value.send(operator, other)
    end

    def next_occurrence
      next_occurrence_after(Time.now.utc)
    end

    def next_occurrence_after(after)
      if recurrence_unit = ATTR_RECURRENCE[@attribute]
        reset_primacy = ATTR_RESET[@attribute]
        reset_index = ATTR_PRIMACY.index(reset_primacy) || 0
        updated_attr = { @attribute => @value }
        ATTR_PRIMACY.each_with_index do |attr, i|
          updated_attr[attr] = ATTR_RESET_VALUES[attr] if i <= reset_index
        end
        occurrence = after.change(updated_attr)
        if @attribute == :year and @value < after.year
          nil
        elsif after < occurrence
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

    def to_temporal_expression
      [operator, @attribute, @value]
    end

  end

  def self.ComparisonPredicate(operator)
    Class.new(ComparisonPredicate) { @operator = operator }
  end

  # Subclasses
  InclusionPredicate          = ComparisonPredicate(:include?)
  ExclusionPredicate          = ComparisonPredicate(:exclude?)
  EqualityPredicate           = ComparisonPredicate(:==)
  GreaterThanPredicate        = ComparisonPredicate(:>)
  GreaterThanOrEqualPredicate = ComparisonPredicate(:>=)
  LessThanPredicate           = ComparisonPredicate(:<)
  LessThanOrEqualPredicate    = ComparisonPredicate(:<=)

end
