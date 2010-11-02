require "date"
require "time"

require "active_support/basic_object"
require "active_support/duration"
%w[date date_time time].each do |duck|
  require "active_support/core_ext/#{duck}/acts_like"
  require "active_support/core_ext/#{duck}/calculations"
  require "active_support/core_ext/#{duck}/conversions"
end

require "clockwork/core_ext/day_precision"
require "clockwork/core_ext/second_precision"
require "clockwork/core_ext/human_date_values"
require "clockwork/core_ext/unit_values"
