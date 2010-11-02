Bundler.setup(:default, :test)

require "pathname"
require "clockwork"

DATE_ATTRIBUTES = [:year, :month, :day]
DATETIME_ATTRS  = DATE_ATTRIBUTES + [:hour, :min, :sec]
TIME_ATTRIBUTES = DATETIME_ATTRS + [:usec]

DERIVED_ATTRS = [:yday, :wday]
DAY_PRECISION_UNITS     = DATE_ATTRIBUTES + DERIVED_ATTRS
SECOND_PRECISION_UNITS  = DATETIME_ATTRS  + DERIVED_ATTRS
USECOND_PRECISION_UNITS = TIME_ATTRIBUTES + DERIVED_ATTRS

# Wed Sep 24 18:30:15 -0700 2008, 500 usec
VALUES = {
  :year  => 2008,
  :month => 9,
  :day   => 24,
  :hour  => 18,
  :min   => 30,
  :sec   => 15,
  :usec  => 500,
  :yday  => 268,
  :yweek => 3,
  :wday  => 3,
  :wday_in_month => 4,
}
