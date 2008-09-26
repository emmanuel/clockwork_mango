module Clockwork
  module Dsl
    WEEKDAYS = %w[sunday monday tuesday wednesday thursday friday saturday]
    WEEKDAYS_PLURAL = %w[sundays mondays tuesdays wednesdays thursdays 
      fridays saturdays]
    MONTHS = %w[january february march april may june july august september november december]
    MONTHS_PLURAL = %w[januaries februaries marches aprils mays junes julys 
      augusts septembers novembers decembers]

    def self.define_arity_zero_expression_builder(name, attribute, value)
      define_method(name) do
        Assertion.new(attribute, value)
      end
    end

    WEEKDAYS.each_with_index do |wday, index|
      define_arity_zero_expression_builder(wday, :wday, index)
    end

    WEEKDAYS_PLURAL.each_with_index do |wday, index|
      define_arity_zero_expression_builder(wday, :wday, index)
    end

    MONTHS.each_with_index do |month, index|
      define_arity_zero_expression_builder(month, :month, index + 1)
    end

    MONTHS_PLURAL.each_with_index do |month, index|
      define_arity_zero_expression_builder(month, :month, index + 1)
    end

    def self.define_arity_one_expression_builder(name, attribute)
      define_method(name) do |value|
        Assertion.new(attribute, value)
      end
    end
    
    %w[year month mday wday hour min sec usec yweek yday 
      wday_in_month].each do |attribute|
        define_arity_one_expression_builder(attribute, attribute)
    end
    
    def at(time_array)
      hh, mm, ss = time_array
      if !(0..23).include?(hh)
        raise ArgumentError, "invalid hour specified (#{hh})"
      elsif !mm.nil? and !(0..59).include?(mm)
        raise ArgumentError, "invalid minute specified (#{mm})"
      elsif !ss.nil? and !(0..59).include?(ss)
        raise ArgumentError, "invalid second specified (#{ss})"
      end
      
      if mm.nil?
        hour(hh)
      elsif ss.nil?
        hour(hh) & min(mm)
      else
        hour(hh) & min(mm) & sec(ss)
      end
    end
    
    def from(time_range)
      raise NotImplementedError, "TODO"
      # TODO: unroll time_range into Union expressions
    end
  end # module Dsl
end # module Clockwork
