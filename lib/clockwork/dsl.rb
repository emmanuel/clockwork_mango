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
    # @param [Integer, Symbol] ordinal (optional)
    #   define intersecting :wday_in_month Assertion if provided.
    #   Symbols will be used to look up an integer value in ORDINAL_MAP.
    #   If no value is found, no :wday_in_month assertion will be intersected
    # 
    # @return [Clockwork::Assertion, Clockwork::Intersection]
    #   a :wday Assertion or Intersection of :wday & :wday_in_month or :wday_in_year
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
    
    # Builds a ProcAssertion using the provided block
    # 
    # @param [Proc] block
    #   will be called with a Date-ish object being tested with #===
    # @return [Clockwork::ProcAssertion]
    #   a ProcAssertion configured with the provided block
    def proc(&block)
      ProcAssertion.new(&block)
    end
    
    ATTRIB_VALID_RANGES = {
      :month => -11..11,
      :mday  => -30..30,
      :wday  => -6..6,
      :hour  => -23..23,
      :min   => -59..59,
      :sec   => -60..60,
    }
    # Builds an Expression that will match the given time of day, 
    #   at the given precision (hour, minute, or second)
    # 
    #   now = Time.now
    #   exp = Clockwork::Dsl.at([9,15])
    #   exp === Time.utc(now.year, now.month, now.mday, 9, 15)  #=> true
    # 
    # @param [Array(Integer)] time_array
    #   an array of hour, minute[, second] Integer values
    # 
    # @return [Clockwork::Assertion, Clockwork::Intersection]
    #   an Expression that matches the given time of day, 
    #   at the precision of the +time_array+ component[s]
    def at(time_array)
      hh, mm, ss = *time_array
      if not (hh.is_a?(Integer) and ATTRIB_VALID_RANGES[:hour].include?(hh))
        raise ArgumentError, "invalid hour specified (#{hh.inspect})"
      elsif not (mm.nil? or ATTRIB_VALID_RANGES[:min].include?(mm))
        raise ArgumentError, "invalid minute specified (#{mm.inspect})"
      # there can be 61 seconds in a minute to allow second injection
      elsif not (ss.nil? or ATTRIB_VALID_RANGES[:sec].include?(ss))
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
    # @param [Range(Array(Integer)..Array(Integer))] time_range
    #   a Range bounded at each end by an array of hour, minute[, second] Integers
    # 
    # @return [Clockwork::Intersection, Clockwork::Union]
    #   an Expression that matches the given range of time of day,
    #   at the precision of the +time_range+ endpoints
    def from(time_range)
      raise NotImplementedError, "TODO"
      # TODO: unroll time_range into Union expressions:
      #   [9,15]..[12,45] => 
      #   (hour(9) & min(15..59)) | hour(10) | hour(11) | (hour(12) & min (0..45))
      # Also:
      #   [9,15,30]..[12,45,55] => 
      #   (hour(9) & ((min(15) & sec(30..60)) | min(16..59))) | hour(10..11) | (hour(12) & (min(0..44) | (min(45) & sec(0..55))))
      unless time_range.respond_to?(:begin) && time_range.begin.respond_to?(:to_ary) && (1..3).include?(time_range.begin.size)
        raise ArgumentError, "expected range with Array endpoints"
      end
      begin_hh, begin_mm, begin_ss = *time_range.begin
      end_hh, end_mm, end_ss       = *time_range.end
      
      unless [begin_hh, begin_mm, begin_ss].compact.size == [end_hh, end_mm, end_ss].compact.size
        raise ArgumentError, "only endpoints of equal specificity are currently supported"
      end
      
      if !begin_mm && !end_mm     # begin is an hour and end is an hour
        begin_hh < end_hh ? hour(begin_hh..end_hh) : hour(begin_hh)
      elsif !begin_ss && !end_ss  # begin is [hour,min] and end is [hour,min]
        if begin_hh < end_hh
          
        elsif begin_hh == end_hh
        end
      end
    end
    
    def _unroll_array_into_expression(time_array, forward=true)
      hh, mm, ss = *time_array
      if !mm
        hour(hh)
      elsif !ss
        hour(hh) & min(forward ? (mm..59) : (0..mm))
      elsif forward
        hour(hh) & ((min(mm) & sec(ss..60)) | min((mm+1)..59))
      else
        hour(hh) & ((min(mm) & sec(0..ss)) | min(0..(mm-1)))
      end
    end
  end # module Dsl
end # module Clockwork
