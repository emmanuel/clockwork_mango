require "pathname"
require "date"

require "bundler"
Bundler.setup(:default)

require "clockwork_mango/version"
require "clockwork_mango/predicate"
require "clockwork_mango/comparison_predicate"
require "clockwork_mango/proc_predicate"
require "clockwork_mango/compound_predicate"
require "clockwork_mango/dsl"
require "clockwork_mango/core_ext"

# Shortcut to the ClockworkMango::Dsl expression builder dsl. 
# Lets you use the lib from any context like so:
#   ClockworkMango { |c| c.november & c.monday & c.wday_in_month(1) }
# which will return an expression that matches the 1st Monday in November
# 
# @param block <Block> block that will get ClockworkMango::Dsl as a parameter
# 
# @return <ClockworkMango::Predicate> defined by the provided block
def Clockwork(&block)
  ::ClockworkMango::Dsl.build_predicate(&block)
end
