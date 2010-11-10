module ClockworkMango
  module Dsl
    def self.build_predicate(&block)
      if block.arity.zero?
        instance_eval(&block)
      else
        yield(self)
      end
    end

    # Adds a method to the Dsl that will accept a single argument
    # 
    # @param name<String, Symbol> the name of the method to create
    # @param attribute<String, Symbol> the attribute that will be asserted
    def self.define_arity_one_predicate_builder(name, attribute)
      name, attribute = name.to_sym, attribute.to_sym
      define_method(name) do |value|
        if value.respond_to?(:include?)
          InclusionPredicate.new(attribute, value)
        else
          EqualityPredicate.new(attribute, value)
        end
      end
      module_function(name)
    end
    
    # Adds a method to the Dsl that will not accept an argument
    # 
    # @param name<String, Symbol> the name of the method to create
    # @param attribute<String, Symbol> the attribute that will be asserted
    # @param value<Integer, Range> the value of the attribute predicate
    def self.define_arity_zero_predicate_builder(name, attribute, value)
      name, attribute = name.to_sym, attribute.to_sym
      if value.respond_to?(:include?)
        define_method(name) do
          InclusionPredicate.new(attribute, value)
        end
      else
        define_method(name) do
          EqualityPredicate.new(attribute, value)
        end
      end

      module_function(name)
    end
    
    COMPARABLE_ATTRIBUTES.each do |attribute|
      define_arity_one_predicate_builder(attribute, attribute)
    end
    
    MONTHS = %w[january february march april may june 
      july august september october november december]

    # Build a predicate that matches the named month (and optional month day)
    # 
    # @param [Integer] month_day (optional)
    #   define intersecting :mday EqualityPredicate if provided.
    #   If no month_day value is provided, no :mday predicate will be intersected
    # 
    # @return [ClockworkMango::EqualityPredicate, ClockworkMango::IntersectionPredicate]
    #   a :month EqualityPredicate (if no month_day provided), or
    #   an IntersectionPredicate of :month and :mday (if month_day provided)
    MONTHS.each_with_index do |month, index|
      module_eval <<-RUBY, __FILE__, __LINE__
        def #{month}(month_day=nil)
          if month_day
            month(#{index + 1}) & mday(month_day)
          else
            month(#{index + 1})
          end
        end

        module_function :#{month}
      RUBY
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
    # Build a predicate that matches the named weekday.
    # 
    # @param [Integer, Symbol] ordinal (optional)
    #   define intersecting :wday_in_month EqualityPredicate if provided.
    #   Symbols will be used to look up an integer value in ORDINAL_MAP.
    #   If no value is found, no :wday_in_month predicate will be intersected
    # 
    # @return [ClockworkMango::EqualityPredicate, ClockworkMango::IntersectionPredicate]
    #   a :wday EqualityPredicate or
    #   an IntersectionPredicate of :wday & :wday_in_month/:wday_in_year
    #   (:wday & :wday_in_month) if ordinal provided and ordinal_scope == :month (default)
    #   (:wday & :wday_in_year) if ordinal provided and ordinal_scope == :year
    WEEKDAYS = %w[sunday monday tuesday wednesday thursday friday saturday]
    WEEKDAYS.each_with_index do |wday, index|
      module_eval <<-RUBY, __FILE__, __LINE__
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
      RUBY
      alias_method :"#{wday}s", :"#{wday}"
      module_function :"#{wday}", :"#{wday}s"
    end
    
    module_function
    
    # Builds a ProcPredicate using the provided block
    # 
    # @param [Proc] block
    #   will be called with a Date-ish object being tested with #===
    # @return [ClockworkMango::ProcPredicate]
    #   a ProcPredicate configured with the provided block
    def proc(&block)
      ProcPredicate.new(&block)
    end

    # Builds a Predicate that will match the given time of day, 
    #   at the given precision (hour, minute, or second)
    # 
    #   now = Time.now
    #   predicate = ClockworkMango::Dsl.at(9,15)
    #   predicate === Time.utc(now.year, now.month, now.mday, 9, 15)  #=> true
    # 
    # @param [Integer[, Integer[, Integer]]] time_array
    #   an array of hour[, minute[, second]] Integer values
    # 
    # @return [ClockworkMango::EqualityPredicate, ClockworkMango::IntersectionPredicate]
    #   a Predicate that matches the given time of day, at the precision of the provided args
    def at(hh, mm = nil, ss = nil)
      ClockworkMango::Dsl.validate_hhmmss(hh,mm,ss)

      if mm.nil?
        hour(hh)
      elsif ss.nil?
        hour(hh) & min(mm)
      else
        hour(hh) & min(mm) & sec(ss)
      end
    end

    def self.validate_hhmmss(hh, mm, ss)
      if not (hh.is_a?(Integer) and VALID_HOUR_RANGE.include?(hh))
        raise ArgumentError, "invalid hour specified (#{hh.inspect})"
      elsif not (mm.nil? or VALID_MIN_RANGE.include?(mm))
        raise ArgumentError, "invalid minute specified (#{mm.inspect})"
      elsif not (ss.nil? or VALID_SEC_RANGE.include?(ss))
        raise ArgumentError, "invalid second specified (#{ss.inspect})"
      end
    end

    def self.validate_time_range(time_range)
      unless time_range.respond_to?(:end) && time_range.end.respond_to?(:to_ary) &&
        time_range.respond_to?(:begin) && time_range.begin.respond_to?(:to_ary)

        if (1..3).include?(time_range.end.size) && (1..3).include?(time_range.begin.size)
          raise ArgumentError, "expected Range with Array endpoints"
        else
          raise ArgumentError, "Array endpoints must have length within 1..3"
        end
      end
    end

    def until(hh, mm = nil, ss = nil)
      ClockworkMango::Dsl.validate_hhmmss(hh,mm,ss)

      if mm.nil?
        LessThanOrEqualPredicate.new(:hour, hh)
      elsif ss.nil?
        LessThanPredicate.new(:hour, hh) | (
          EqualityPredicate.new(:hour, hh) &
          LessThanOrEqualPredicate.new(:min, mm))
      else
        LessThanPredicate.new(:hour, hh) | (
          EqualityPredicate.new(:hour, hh) & (
            LessThanPredicate.new(:min, mm) | (
            EqualityPredicate.new(:min, mm) & LessThanOrEqualPredicate.new(:sec, ss))))
      end
    end

    def from(*args)
      if args.length == 1 and args.first.is_a?(Range)
        time_range = args.first
        ClockworkMango::Dsl.validate_time_range(time_range)
        from_time_range(time_range)
      else
        hh, mm, ss = args
        ClockworkMango::Dsl.validate_hhmmss(hh, mm, ss)
        from_hhmmss(hh, mm, ss)
      end
    end

    def from_hhmmss(hh, mm = nil, ss = nil)
      ClockworkMango::Dsl.validate_hhmmss(hh,mm,ss)

      if mm.nil?
        GreaterThanOrEqualPredicate.new(:hour, hh)
      elsif ss.nil?
        GreaterThanPredicate.new(:hour, hh) | (
          EqualityPredicate.new(:hour, hh) &
          GreaterThanOrEqualPredicate.new(:min, mm))
      else
        GreaterThanPredicate.new(:hour, hh) | (
          EqualityPredicate.new(:hour, hh) & (
            GreaterThanPredicate.new(:min, mm) | (
            EqualityPredicate.new(:min, mm) & GreaterThanOrEqualPredicate.new(:sec, ss))))
      end
    end

    MAX_HH = 23
    MAX_MM = 59
    MAX_SS = 60

    # Builds a Predicate that will match the given range of time of day, 
    #   at the given precision (hour, minute, or second)
    #
    # @param [Range(Array(Integer)..Array(Integer))] time_range
    #   a Range bounded at each end by an array of
    #   hour, minute[, second] Integers
    #
    # @return [ClockworkMango::IntersectionPredicate, ClockworkMango::UnionPredicate]
    #   a Predicate that matches the given range of time of day,
    #   at the precision of the +time_range+ endpoints
    # 
    # Implementation unrolls +time_range+ into UnionPredicate predicates:
    #   ClockworkMango::Dsl.from([9,15]..[12,45])
    #   # => (hour(9) & min(15..59)) | hour(10..11) | (hour(12) & min (0..45))
    # Or:
    #   ClockworkMango::Dsl.from([9]..[12,45])
    #   # => hour(9..11) | (hour(12) & min (0..45))
    # Also:
    #   ClockworkMango::Dsl.from([9,15]..[12,45,55])
    #   # => (hour(9) & min(15..59)) | hour(10..11) | (hour(12) & (min(0..44) | (min(45) & sec(0..55))))
    def from_time_range(time_range)
      begin_hh, begin_mm, begin_ss = *time_range.begin
      end_hh,   end_mm,   end_ss   = *time_range.end
      delta_hh = end_hh - begin_hh  # hh is required
      delta_mm = (end_mm - begin_mm rescue nil)
      delta_ss = (end_ss - begin_ss rescue nil)

      case delta_hh
      when 3..MAX_HH  # => from([9,45,15]..[12,10])
        case delta_mm
        when nil
          middle = nil
          if begin_mm
            beginning = unroll_hhmmss_into_partial_hour_predicate(time_range.begin)
            ending    = hour((begin_hh + 1)..end_hh)
          elsif end_mm
            beginning = hour(begin_hh..(end_hh - 1))
            ending    = unroll_hhmmss_into_partial_hour_predicate(time_range.end, true)
          else
            beginning = hour(begin_hh..end_hh)
            ending    = nil
          end
        when -MAX_MM..MAX_MM
          beginning = unroll_hhmmss_into_partial_hour_predicate(time_range.begin)
          middle    = hour((begin_hh + 1)..(end_hh - 1))
          ending    = unroll_hhmmss_into_partial_hour_predicate(time_range.end, true)
        else
          raise ArgumentError, "Invalid begin_mm (#{begin_mm.inspect}) and end_mm (#{end_mm.inspect})"
        end
        return beginning | middle | ending
      when 2          # => from([9,45,15]..[11,47,45])
        beginning = unroll_hhmmss_into_partial_hour_predicate(time_range.begin)
        middle    = hour(begin_hh + 1)
        ending    = unroll_hhmmss_into_partial_hour_predicate(time_range.end, true)
        return beginning | middle | ending
      when 1          # => from([9,45,15]..[10,47,45])
        beginning = unroll_hhmmss_into_partial_hour_predicate(time_range.begin)
        ending    = unroll_hhmmss_into_partial_hour_predicate(time_range.end, true)
        return beginning | ending
      when 0            # => from([9,15]..[9,45])
        case delta_mm
        when 3..MAX_MM  # => from([9,15]..[9,18])
          beginning = unroll_mmss_into_partial_minute_predicate(begin_mm, begin_ss)
          middle    = min((begin_mm + 1)..(end_mm - 1))
          ending    = unroll_mmss_into_partial_minute_predicate(end_mm, end_ss, true)
          rest      = beginning | middle | ending
        when 2          # => from([9,45,15]..[9,47,45])
          beginning = unroll_mmss_into_partial_minute_predicate(begin_mm, begin_ss)
          middle    = min(begin_mm + 1)
          ending    = unroll_mmss_into_partial_minute_predicate(end_mm, end_ss, true)
          rest      = beginning | middle | ending
        when 1          # => from([9,45,15]..[9,46,45])
          beginning = unroll_mmss_into_partial_minute_predicate(begin_mm, begin_ss)
          ending    = unroll_mmss_into_partial_minute_predicate(end_mm, end_ss, true)
          rest      = beginning | ending
        when 0          # => from([9,45,10]..[9,45,45])
          case delta_ss
          when nil        # => from([9,15]..[9,15])
            minutes = min(begin_mm)
          when 0          # => from([9,15,45]..[9,15,45])
            minutes = min(begin_mm) & sec(begin_ss)
          when 1..MAX_SS  # => from([9,15,15]..[9,15,45])
            minutes = min(begin_mm) & sec(begin_ss..end_ss)
          else
            raise ArgumentError, "Invalid begin_ss (#{begin_ss.inspect}) and end_ss (#{end_ss.inspect})"
          end
          return hour(begin_hh) & minutes
        when nil
          if end_mm       # => from([9]..[9,45])
            unroll_hhmmss_into_partial_hour_predicate(time_range.end, true)
          elsif begin_mm  # => from([9,45]..[9])
            raise ArgumentError, "Invalid endpoints: #{time_range.begin.inspect}..#{time_range.end.inspect}"
          else            # => from([9]..[9])
            return hour(begin_hh)
          end
        else
          raise ArgumentError, "Invalid begin_mm (#{begin_mm.inspect}) and end_mm (#{end_mm.inspect})"
        end
        return hour(begin_hh) & rest
      else
        raise ArgumentError, "Invalid begin_hh (#{begin_hh.inspect}) and end_hh (#{end_hh.inspect})"
      end
    end

    # unrolls a set of mm[, ss] args
    def unroll_mmss_into_partial_minute_predicate(time_array, end_at_beginning=false)
      mm, ss = *time_array
      raise ArgumentError, "invalid mm parameter: #{mm.inspect}" unless mm.kind_of?(Fixnum)
      if !ss      # no +ss+ then there's nothing to unroll
        min(mm)
      elsif end_at_beginning    # unroll the predicate towards the beginning of the minute
        case ss
        when 1..MAX_SS    # => unroll_mmss_into_partial_minute_predicate([45,30], true)
          seconds = sec(0..ss)
        when 0            # => unroll_mmss_into_partial_minute_predicate([45,0], true)
          seconds = sec(ss)
        else
          raise ArgumentError, "Invalid ss argument: #{ss.inspect}"
        end
        return min(mm) & seconds
      else
        case ss
        when 0..(MAX_SS - 1)
          seconds = sec(ss..MAX_SS)
        when MAX_SS
          seconds = sec(ss)
        else
          raise ArgumentError, "Invalid ss argument: #{ss.inspect}"
        end
        return min(mm) & seconds
      end
    end

    # unrolls a set of hh[, mm[, ss]] args into a Predicate that matches a
    # partial hour, using +time_array+ to define either the beginning, or the end
    def unroll_hhmmss_into_partial_hour_predicate(time_array, end_at_beginning=false)
      hh, mm, ss = *time_array
      raise ArgumentError, "invalid hh parameter: #{hh.inspect}" unless hh.kind_of?(Fixnum)
      if !mm      # no +mm+ then there's nothing to unroll
        return hour(hh)
      elsif !ss   # no +ss+ then the permutations to unroll aren't too bad
        if end_at_beginning
          case mm
          when 1..MAX_MM
            minutes = min(0..mm)
          when 0
            minutes = min(mm)
          else
            raise ArgumentError, "Invalid mm argument: #{mm.inspect}"
          end
        else
          case mm
          when 0..(MAX_MM - 1)
            minutes = min(mm..MAX_MM)
          when MAX_MM
            minutes = min(mm)
          else
            raise ArgumentError, "Invalid mm argument: #{mm.inspect}"
          end
        end
        return hour(hh) & minutes
      elsif end_at_beginning  # with +hh+, +mm+, and +ss+, there are tons of possibilities
        case mm
        when 2..MAX_MM  # use a range of minutes
          case ss
          when 0..MAX_SS
            minutes = min(0..(mm-1)) | unroll_mmss_into_partial_minute_predicate([mm, ss], true)
          else
            raise ArgumentError, "Invalid ss argument: #{ss.inspect}"
          end
        when 1
          minutes = min(0) | unroll_mmss_into_partial_minute_predicate([mm, ss], true)
        when 0
          minutes = unroll_mmss_into_partial_minute_predicate([mm, ss], true)
        else
          raise ArgumentError, "Invalid mm argument: #{mm.inspect}"
        end
        return hour(hh) & minutes
      else
        case mm
        when 0..(MAX_MM - 2)
          case ss
          when 0..MAX_SS
            minutes = min((mm+1)..MAX_MM) | unroll_mmss_into_partial_minute_predicate([mm, ss])
          else
            raise ArgumentError, "Invalid ss argument: #{ss.inspect}"
          end
        when (MAX_MM - 1)
          case ss
          when 0..MAX_SS
            minutes = min(MAX_MM) | unroll_mmss_into_partial_minute_predicate([mm, ss])
          else
            raise ArgumentError, "Invalid ss argument: #{ss.inspect}"
          end
        when MAX_MM
          case ss
          when 0..MAX_SS
            minutes = unroll_mmss_into_partial_minute_predicate([mm, ss])
          else
            raise ArgumentError, "Invalid ss argument: #{ss.inspect}"
          end
        else
          raise ArgumentError, "Invalid mm argument: #{mm.inspect}"
        end
        return hour(hh) & minutes
      end
    end

  end # module Dsl
end # module ClockworkMango
