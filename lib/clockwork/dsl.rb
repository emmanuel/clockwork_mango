module Clockwork
  module Dsl
    # Adds a method to the Dsl that will accept a single argument
    # 
    # @param name<String, Symbol> the name of the method to create
    # @param attribute<String, Symbol> the attribute that will be asserted
    def self.define_arity_one_expression_builder(name, attribute)
      name, attribute = name.to_sym, attribute.to_sym
      define_method(name) do |value|
        Assertion.new(attribute, value)
      end
      module_function(name)
    end
    
    # Adds a method to the Dsl that will not accept an argument
    # 
    # @param name<String, Symbol> the name of the method to create
    # @param attribute<String, Symbol> the attribute that will be asserted
    # @param value<Integer, Range> the value of the attribute assertion
    def self.define_arity_zero_expression_builder(name, attribute, value)
      name, attribute = name.to_sym, attribute.to_sym
      define_method(name) do
        Assertion.new(attribute, value)
      end
      module_function(name)
    end
    
    ASSERTABLE_ATTRIBUTES.each do |attribute|
      define_arity_one_expression_builder(attribute, attribute)
    end
    
    WEEKDAYS = %w[sunday monday tuesday wednesday thursday friday saturday]
    WEEKDAYS.each_with_index do |wday, index|
      define_arity_zero_expression_builder(wday, :wday, index)
      define_arity_zero_expression_builder("#{wday}s", :wday, index)
    end
    
    MONTHS = %w[january february march april may june 
      july august september october november december]
    MONTHS.each_with_index do |month, index|
      define_arity_zero_expression_builder(month, :month, index + 1)
    end
    
    module_function
    
    # Builds an Expression that will match the given time of day, 
    #   at the given precision (hour, minute, or second)
    # 
    # @param time_array<Array[<Integer>]> an array of hour, minute[, second]
    #   Integer values
    # 
    # @return <Expression> an Expression that matches the given time of day, 
    #   at the precision of the time_array component[s]
    def at(time_array)
      hh, mm, ss = time_array
      if not (hh.is_a?(Integer) and (0..23).include?(hh))
        raise ArgumentError, "invalid hour specified (#{hh.inspect})"
      elsif not (mm.nil? or (0..59).include?(mm))
        raise ArgumentError, "invalid minute specified (#{mm.inspect})"
      # yes, there can be 61 seconds in a minute (to allow second injection)
      elsif not (ss.nil? or (0..60).include?(ss))
        raise ArgumentError, "invalid second specified (#{ss.inspect})"
      end
      
      if mm.nil?
        hour(hh)
      elsif ss.nil?
        hour(hh) & min(mm)
      else
        hour(hh) & min(mm) & sec(ss)
      end
    end
    
    # Builds an Expression that will match the given range of time of day, 
    #   at the given precision (hour, minute, or second)
    # 
    # @param time_range<Range(Array[<Integer>]..Array[<Integer>])> a Range 
    #   bounded at each end by an array of hour, minute[, second] Integers
    # 
    # @return <Expression> an Expression that matches the given range 
    #   of time of day, at the precision of the time_range endpoints
    def from(time_range)
      raise NotImplementedError, "TODO"
      # TODO: unroll time_range into Union expressions:
      #   [9,15]..[12,45] => 
      #   (hour(9) & min(15..59)) | hour(10) | hour(11) | (hour(12) & min (0..45))
      # Also:
      #   [9,15,30]..[12,45] => 
      #   (hour(9) & ((min(15) & sec(30..60)) | min(16..59))) | hour(10) | hour(11) | (hour(12) & min (0..45))
    end
  end # module Dsl
end # module Clockwork
