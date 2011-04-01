module ClockworkMango
  module Constants
    COMPARABLE_ATTRIBUTES = [:year, :month, :day, :hour, :min, :sec, :usec,
      :yday, :yweek, :mweek, :wday, :wday_in_month]

    REVERSIBLE_ATTRIBUTES = [:month, :day, :hour, :min, :sec, :usec,
      :yday, :yweek, :mweek, :wday, :wday_in_month]

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