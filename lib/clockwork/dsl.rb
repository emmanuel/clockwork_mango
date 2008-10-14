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
    
    MONTHS = %w[january february march april may june 
      july august september october november december]
    MONTHS.each_with_index do |month, index|
      define_arity_zero_expression_builder(month, :month, index + 1)
    end
    
    ORDINAL_MAP = {
      :first  => 1,
      :second => 2,
      :third  => 3,
      :fourth => 4,
      :fifth  => 5,

      :last   => -1,
      :second_to_last => -2,
    }
    # Build an assertion that matches the named weekday.
    # 
    # @param ordinal [<Integer>, <Symbol>] (optional) used to define 
    #   intersecting :wday_in_month Assertion if provided. Symbols will be used 
    #   to look up an integer value in ORDINAL_MAP. If not ordinal is not found, 
    #   no :wday_in_month assertion will be intersected
    # 
    # @return <Clockwork::Expression> an Assertion (:wday) or Intersection 
    #   (:wday & :wday_in_month) if ordinal provided and ordinal_scope == :month (default)
    #   (:wday & :wday_in_year) if ordinal provided and ordinal_scope == :year
    WEEKDAYS = %w[sunday monday tuesday wednesday thursday friday saturday]
    WEEKDAYS.each_with_index do |wday, index|
      method_def = <<-END_EVAL
        def #{wday}(ordinal=nil, ordinal_scope=:month)
          ordinal = ORDINAL_MAP[ordinal] if ordinal.is_a?(Symbol)
          wday_assertion = wday(#{index})
          if ordinal
            case ordinal_scope
            when :month
              wday_assertion & wday_in_month(ordinal)
            when :year
              wday_assertion & wday_in_year(ordinal)
            end
          else
            wday_assertion
          end
        end
      END_EVAL
      self.module_eval method_def, __FILE__, __LINE__
      alias_method :"#{wday}s", :"#{wday}"
      module_function :"#{wday}", :"#{wday}s"
    end
    
    module_function
    
    def proc(&block)
      ProcAssertion.new(&block)
    end
    
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
