lib = File.dirname(__FILE__)
$LOAD_PATH << lib unless $LOAD_PATH.include?(lib)

require "clockwork_mango/version"
require "clockwork_mango/core_ext"
require "clockwork_mango/predicate/base"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"
require "clockwork_mango/dsl"

# Shortcut to the ClockworkMango::Dsl.build_predicate dsl. 
# Lets you use the lib from any context like so:
#   Clockwork { |c| c.november & c.wday_in_month(1) & c.monday }
# or without the block variable:
#   Clockwork { november & wday_in_month(1) & monday }
# Both of which will return an expression that matches the 1st Monday in November
# 
# @param block <Block> block that will get ClockworkMango::Dsl as a parameter,
#   or instance_eval'd in the context of ClockworkMango::Dsl if arity zero
# 
# @return <ClockworkMango::Predicate> defined by the provided block
def Clockwork(&block)
  ::ClockworkMango::Dsl.build_predicate(&block)
end
