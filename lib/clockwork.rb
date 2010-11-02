require "pathname"
require "date"

require "bundler"
Bundler.setup(:default)

require "clockwork/version"
require "clockwork/predicate"
require "clockwork/comparison_predicate"
require "clockwork/proc_predicate"
require "clockwork/compound_predicate"
require "clockwork/dsl"
require "clockwork/core_ext"

# Shortcut to the Clockwork::Dsl expression builder dsl. 
# Lets you use the lib from any context like so:
#   Clockwork { |c| c.november & c.monday & c.wday_in_month(1) }
# which will return an expression that matches the 1st Monday in November
# 
# @param block <Block> block that will get Clockwork::Dsl as a parameter
# 
# @return <Clockwork::Predicate> defined by the provided block
def Clockwork(&block)
  ::Clockwork::Dsl.build_predicate(&block)
end
