require "pathname"

module Clockwork
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 1
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].join('.')
    self
  end # module VERSION
end # module Clockwork

lib_dir = Pathname(__FILE__).dirname.expand_path
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

require "clockwork/expression"
require "clockwork/assertion"
require "clockwork/compound"
require "clockwork/dsl"
require "clockwork/core_ext"

# Shortcut to the Clockwork::Dsl expression builder dsl. 
# Lets you use the lib from any context like so:
#   Clockwork { |c| c.november & c.monday & c.wday_in_month(1) }
# which will return an expression that matches the 1st Monday in November
# 
# @param block <Block> block that will get Clockwork::Dsl as a parameter
# 
# @return <Clockwork::Expression> defined by the provided block
def Clockwork(&block)
  yield(Clockwork::Dsl)
end
