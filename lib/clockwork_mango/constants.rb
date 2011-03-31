module ClockworkMango
  module Constants
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
  end
end