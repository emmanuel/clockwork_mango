require "date"
require "time"

require "active_support/basic_object"
require "active_support/duration"
%w[date date_time time].each do |temporal|
  require "active_support/core_ext/#{temporal}/acts_like"
  require "active_support/core_ext/#{temporal}/calculations"
  require "active_support/core_ext/#{temporal}/conversions"
end

require "clockwork_mango/core_ext/day_precision"
require "clockwork_mango/core_ext/second_precision"
require "clockwork_mango/core_ext/human_date_values"
require "clockwork_mango/core_ext/unit_values"

require "clockwork_mango/core_ext/exclude"
