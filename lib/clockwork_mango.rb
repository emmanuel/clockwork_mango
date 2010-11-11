require "pathname"
require "date"

# require "bundler"
# Bundler.setup(:default)
unless $LOAD_PATH.include?(File.dirname(__FILE__))
  $LOAD_PATH << File.dirname(__FILE__)
end

require "clockwork_mango/version"
require "clockwork_mango/predicate"
require "clockwork_mango/comparison_predicate"
require "clockwork_mango/compound_predicate"
require "clockwork_mango/dsl"
require "clockwork_mango/core_ext"

# Shortcut to the ClockworkMango::Dsl.predicate_builder dsl. 
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
