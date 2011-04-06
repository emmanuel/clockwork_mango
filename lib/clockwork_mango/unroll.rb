module ClockworkMango
  # TODO: refactor this into a TimeRange object
  # (MAYBE) use PrecisionedTime instances as endpoints
  module Unroll
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
    # @return [ClockworkMango::Predicate::Intersection, ClockworkMango::Predicate::Union]
    #   a Predicate that matches the given range of time of day,
    #   at the precision of the +time_range+ endpoints
    # 
    # Implementation unrolls +time_range+ into Predicate::Unions:
    #   ClockworkMango::Dsl.from([9,15]..[12,45])
    #   # => (hour(9) & min(15..59)) | hour(10..11) | (hour(12) & min (0..45))
    # Or:
    #   ClockworkMango::Dsl.from([9]..[12,45])
    #   # => hour(9..11) | (hour(12) & min (0..45))
    # Also:
    #   ClockworkMango::Dsl.from([9,15]..[12,45,55])
    #   # => (hour(9) & min(15..59)) | hour(10..11) | (hour(12) & (min(0..44) | (min(45) & sec(0..55))))
    def self.time_range(time_range)
      validate_time_range(time_range)

      begin_hh = time_range.begin.first
      end_hh   = time_range.end.first
      delta_hh = end_hh - begin_hh  # hh is required

      case delta_hh
      when 3..MAX_HH ; multihour_delta(time_range)  # => from([9,45,15]..[12,10])
      when 2         ; two_hour_delta(time_range)   # => from([9,45,15]..[11,47,45])
      when 1         ; one_hour_delta(time_range)   # => from([9,45,15]..[10,47,45])
      when 0         ; zero_hour_delta(time_range)  # => from([9,15]..[9,45])
      when -23..-1   ; negative_hour_delta(time_range)
      else
        message = "Invalid begin_hh (#{begin_hh.inspect}) and end_hh (#{end_hh.inspect})"
        raise ArgumentError, message
      end
    end

    def self.hhmmss(hh, mm = nil, ss = nil)
      validate_hhmmss(hh,mm,ss)

      if mm.nil?
        Predicate::GreaterThanOrEqual.new(:hour, hh)
      elsif ss.nil?
        Predicate::GreaterThan.new(:hour, hh) | (
          Predicate::Equality.new(:hour, hh) &
          Predicate::GreaterThanOrEqual.new(:min, mm))
      else
        Predicate::GreaterThan.new(:hour, hh) | (
          Predicate::Equality.new(:hour, hh) & (
            Predicate::GreaterThan.new(:min, mm) | (
            Predicate::Equality.new(:min, mm) & Predicate::GreaterThanOrEqual.new(:sec, ss))))
      end
    end

    def self.multihour_delta(time_range)
      begin_hh, begin_mm, begin_ss = *time_range.begin
      end_hh,   end_mm,   end_ss   = *time_range.end
      delta_hh = end_hh - begin_hh  # hh is required
      delta_mm = (end_mm - begin_mm rescue nil)
      delta_ss = (end_ss - begin_ss rescue nil)

      case delta_mm
      when nil
        middle = nil
        if begin_mm
          beginning = Unroll.hhmmss_into_partial_hour_predicate(begin_hh, begin_mm, begin_ss)
          ending    = Predicate::Inclusion.new(:hour, (begin_hh + 1)..end_hh)
        elsif end_mm
          beginning = Predicate::Inclusion.new(:hour, begin_hh..(end_hh - 1))
          ending    = Unroll.hhmmss_into_partial_hour_predicate(end_hh, end_mm, end_ss, true)
        else
          beginning = Predicate::Inclusion.new(:hour, begin_hh..end_hh)
          ending    = nil
        end
      when Predicate::Comparison::VALID_MIN_RANGE
        beginning = Unroll.hhmmss_into_partial_hour_predicate(begin_hh, begin_mm, begin_ss)
        middle    = Predicate::Inclusion.new(:hour, (begin_hh + 1)..(end_hh - 1))
        ending    = Unroll.hhmmss_into_partial_hour_predicate(end_hh, end_mm, end_ss, true)
      else
        raise ArgumentError, "Invalid begin_mm (#{begin_mm.inspect}) and end_mm (#{end_mm.inspect})"
      end
      return beginning | middle | ending
    end

    def self.two_hour_delta(time_range)
      begin_hh, begin_mm, begin_ss = *time_range.begin
      end_hh,   end_mm,   end_ss   = *time_range.end

      beginning = Unroll.hhmmss_into_partial_hour_predicate(begin_hh, begin_mm, begin_ss)
      middle    = Predicate::Equality.new(:hour, begin_hh + 1)
      ending    = Unroll.hhmmss_into_partial_hour_predicate(end_hh, end_mm, end_ss, true)

      beginning | middle | ending
    end

    def self.one_hour_delta(time_range)
      begin_hh, begin_mm, begin_ss = *time_range.begin
      end_hh,   end_mm,   end_ss   = *time_range.end

      beginning = Unroll.hhmmss_into_partial_hour_predicate(begin_hh, begin_mm, begin_ss)
      ending    = Unroll.hhmmss_into_partial_hour_predicate(end_hh, end_mm, end_ss, true)

      beginning | ending
    end

    def self.zero_hour_delta(time_range)
      begin_hh, begin_mm, begin_ss = *time_range.begin
      end_hh,   end_mm,   end_ss   = *time_range.end
      delta_hh = end_hh - begin_hh  # hh is required
      delta_mm = (end_mm - begin_mm rescue nil)
      delta_ss = (end_ss - begin_ss rescue nil)

      case delta_mm
      when 3..MAX_MM  # => from([9,15]..[9,18])
        beginning = Unroll.mmss_to_partial_minute_predicate(begin_mm, begin_ss)
        middle    = Predicate::Inclusion.new(:min, (begin_mm + 1)..(end_mm - 1))
        ending    = Unroll.mmss_to_partial_minute_predicate(end_mm, end_ss, true)
        rest      = beginning | middle | ending
      when 2          # => from([9,45,15]..[9,47,45])
        beginning = Unroll.mmss_to_partial_minute_predicate(begin_mm, begin_ss)
        middle    = Predicate::Equality.new(:min, begin_mm + 1)
        ending    = Unroll.mmss_to_partial_minute_predicate(end_mm, end_ss, true)
        rest      = beginning | middle | ending
      when 1          # => from([9,45,15]..[9,46,45])
        beginning = Unroll.mmss_to_partial_minute_predicate(begin_mm, begin_ss)
        ending    = Unroll.mmss_to_partial_minute_predicate(end_mm, end_ss, true)
        rest      = beginning | ending
      when 0          # => from([9,45,10]..[9,45,45])
        case delta_ss
        when nil        # => from([9,15]..[9,15])
          minutes = Predicate::Equality.new(:min, begin_mm)
        when 0          # => from([9,15,45]..[9,15,45])
          minutes = Predicate::Equality.new(:min, begin_mm) &
                      Predicate::Equality.new(:sec, begin_ss)
        when 1..MAX_SS  # => from([9,15,15]..[9,15,45])
          minutes = Predicate::Equality.new(:min, begin_mm) &
                      Predicate::Inclusion.new(:sec, begin_ss..end_ss)
        else
          raise ArgumentError, "Invalid begin_ss (#{begin_ss.inspect}) and end_ss (#{end_ss.inspect})"
        end
        return Predicate::Equality.new(:hour, begin_hh) & minutes
      when nil
        if end_mm       # => from([9]..[9,45])
          Unroll.hhmmss_into_partial_hour_predicate(end_hh, end_mm, end_ss, true)
        elsif begin_mm  # => from([9,45]..[9])
          raise ArgumentError, "Invalid endpoints: #{time_range.begin.inspect}..#{time_range.end.inspect}"
        else            # => from([9]..[9])
          return Predicate::Equality.new(:hour, begin_hh)
        end
      else
        raise ArgumentError, "Invalid begin_mm (#{begin_mm.inspect}) and end_mm (#{end_mm.inspect})"
      end

      Predicate::Equality.new(:hour, begin_hh) & rest
    end

    def self.negative_hour_delta(time_range)
      begin_hh, begin_mm, begin_ss = *time_range.begin
      end_hh,   end_mm,   end_ss   = *time_range.end
      delta_hh = end_hh - begin_hh  # hh is required
      delta_mm = (end_mm - begin_mm rescue nil)
      delta_ss = (end_ss - begin_ss rescue nil)

      case delta_mm
      when nil
        middle = nil
        if begin_mm
          beginning = Predicate::Inclusion.new(:hour, (begin_hh + 1)..MAX_HH)
          middle    = Predicate::Inclusion.new(:hour, 0..end_hh)
          ending    = Unroll.hhmmss_into_partial_hour_predicate(begin_hh, begin_mm, begin_ss)
        elsif end_mm
          beginning = Predicate::Inclusion.new(:hour, begin_hh..MAX_HH)
          middle    = Predicate::Inclusion.new(:hour, 0..(end_hh - 1))
          ending    = Unroll.hhmmss_into_partial_hour_predicate(end_hh, end_mm, end_ss, true)
        else
          beginning = Predicate::Inclusion.new(:hour, begin_hh..MAX_HH)
          ending    = Predicate::Inclusion.new(:hour, 0..end_hh)
        end
      when Predicate::Comparison::VALID_MIN_RANGE
        beginning = Unroll.hhmmss_into_partial_hour_predicate(begin_hh, begin_mm, begin_ss)
        middle    = Predicate::Inclusion.new(:hour, 0..(end_hh - 1)) |
                      Predicate::Inclusion.new(:hour, (begin_hh + 1)..MAX_HH)
        ending    = Unroll.hhmmss_into_partial_hour_predicate(end_hh, end_mm, end_ss, true)
      else
        raise ArgumentError, "Invalid begin_mm (#{begin_mm.inspect}) and end_mm (#{end_mm.inspect})"
      end

      beginning | middle | ending
    end

    # unrolls a set of hh[, mm[, ss]] args into a Predicate that matches a
    # partial hour, using +time_array+ to define either the beginning, or the end
    def self.hhmmss_into_partial_hour_predicate(hh, mm, ss, end_at_beginning=false)
      raise ArgumentError, "invalid hh parameter: #{hh.inspect}" unless hh.kind_of?(Fixnum)
      return Predicate::Equality.new(:hour, hh) if !mm      # no +mm+ then there's nothing to unroll

      unless hh.kind_of?(Fixnum)
        raise ArgumentError, "invalid ss parameter: #{ss.inspect}"
      end

      minutes = 
        if !ss   # no +ss+ then the permutations to unroll aren't too bad
          if end_at_beginning
            Unroll.mm_to_partial_hour_predicate_to_end(mm)
          else
            Unroll.mm_to_partial_hour_predicate_from_beginning(mm)
          end
        elsif end_at_beginning  # with +hh+, +mm+, and +ss+, there are tons of possibilities
          Unroll.mmss_to_partial_hour_predicate_to_end(mm, ss)
        else
          Unroll.mmss_to_partial_hour_predicate_from_beginning(mm, ss)
        end

      Predicate::Equality.new(:hour, hh) & minutes
    end

    def self.mm_to_partial_hour_predicate_to_end(mm)
      if (1..MAX_MM).include?(mm)
        Predicate::Inclusion.new(:min, 0..mm)
      elsif 0 == mm
        Predicate::Equality.new(:min, mm)
      else
        raise ArgumentError, "Invalid mm argument: #{mm.inspect}"
      end
    end

    def self.mm_to_partial_hour_predicate_from_beginning(mm)
      if (0..(MAX_MM - 1)).include?(mm)
        Predicate::Inclusion.new(:min, mm..MAX_MM)
      elsif MAX_MM == mm
        Predicate::Equality.new(:min, mm)
      else
        raise ArgumentError, "Invalid mm argument: #{mm.inspect}"
      end
    end

    def self.mmss_to_partial_hour_predicate_to_end(mm, ss)
      case mm
      when 2..MAX_MM  # use a range of minutes
        case ss
        when 0..MAX_SS
          Predicate::Inclusion.new(:min, 0..(mm-1)) | Unroll.mmss_to_partial_minute_predicate(mm, ss, true)
        else
          raise ArgumentError, "Invalid ss argument: #{ss.inspect}"
        end
      when 1
        Predicate::Equality.new(:min, 0) | Unroll.mmss_to_partial_minute_predicate(mm, ss, true)
      when 0
        Unroll.mmss_to_partial_minute_predicate(mm, ss, true)
      else
        raise ArgumentError, "Invalid mm argument: #{mm.inspect}"
      end
    end

    def self.mmss_to_partial_hour_predicate_from_beginning(mm, ss)
      unless (0..MAX_SS).include?(ss)
        raise ArgumentError, "Invalid ss argument: #{ss.inspect}"
      end

      case mm
      when 0..(MAX_MM - 2)
        case ss
        when 0..MAX_SS
          Predicate::Inclusion.new(:min, (mm+1)..MAX_MM) | Unroll.mmss_to_partial_minute_predicate(mm, ss)
        end
      when (MAX_MM - 1)
        case ss
        when 0..MAX_SS
          Predicate::Equality.new(:min, MAX_MM) | Unroll.mmss_to_partial_minute_predicate(mm, ss)
        end
      when MAX_MM
        case ss
        when 0..MAX_SS
          Unroll.mmss_to_partial_minute_predicate(mm, ss)
        end
      else
        raise ArgumentError, "Invalid mm argument: #{mm.inspect}"
      end
    end

    # unrolls a set of mm[, ss] args
    def self.mmss_to_partial_minute_predicate(mm, ss, end_at_beginning=false)
      raise ArgumentError, "invalid mm parameter: #{mm.inspect}" unless mm.kind_of?(Fixnum)
      return Predicate::Equality.new(:min, mm) unless ss      # no +ss+ then there's nothing to unroll
      raise ArgumentError, "Invalid ss argument: #{ss.inspect}" unless (0..MAX_SS).include?(ss)

      seconds =
        if end_at_beginning    # unroll the predicate towards the beginning of the minute
          Unroll.ss_to_partial_minute_predicate_from_beginning(ss)
        else
          Unroll.ss_to_partial_minute_predicate_to_end(ss)
        end

      Predicate::Equality.new(:min, mm) & seconds
    end

    # unrolls a set of mm[, ss] args
    def self.ss_to_partial_minute_predicate_from_beginning(ss)
      if (1..MAX_SS).include?(ss) # => mmss_to_partial_minute_predicate([45,30], true)
        Predicate::Inclusion.new(:sec, 0..ss)
      elsif 0 == ss               # => mmss_to_partial_minute_predicate([45,0], true)
        Predicate::Equality.new(:sec, ss)
      end
    end

    def self.ss_to_partial_minute_predicate_to_end(ss)
      if (0..(MAX_SS - 1)).include?(ss)
        Predicate::Inclusion.new(:sec, ss..MAX_SS)
      elsif MAX_SS == ss
        Predicate::Equality.new(:sec, ss)
      end
    end

    def self.validate_time_range(time_range)
      message =
        if !(time_range.respond_to?(:begin) && time_range.respond_to?(:end))
          "time_range must respond to :begin and :end"
        elsif !(time_range.end.respond_to?(:to_ary) && time_range.begin.respond_to?(:to_ary))
          "time_range must have Array :begin and :end"
        elsif !((1..3).include?(time_range.begin.size) && (1..3).include?(time_range.end.size))
          "Array :begin and :end must have length within 1..3"
        end
      raise(ArgumentError, message) if message

      begin_hh, begin_mm, begin_ss = time_range.begin
      end_hh, end_mm, end_ss = time_range.end
      validate_hhmmss(begin_hh, begin_mm, begin_ss, "begin")
      validate_hhmmss(end_hh,   end_mm,   end_ss,   "end")
    end

    def self.validate_hhmmss(hh, mm, ss, qualifier = "")
      qualifier = qualifier.gsub(/\s*\Z/, " ")
      message =
        if !hh.is_a?(Integer) || !Predicate::Comparison::VALID_HOUR_RANGE.include?(hh)
          "invalid #{qualifier}hour specified (#{hh.inspect})"
        elsif mm && !Predicate::Comparison::VALID_MIN_RANGE.include?(mm)
          "invalid #{qualifier}minute specified (#{mm.inspect})"
        elsif ss && !Predicate::Comparison::VALID_SEC_RANGE.include?(ss)
          "invalid #{qualifier}second specified (#{ss.inspect})"
        end
      raise(ArgumentError, message) if message
    end

  end
end