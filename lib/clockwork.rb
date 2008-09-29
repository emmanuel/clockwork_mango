require "pathname"

module Clockwork
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 1
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].join('.')
    self
  end # module VERSION
  
  LIBDIR = Pathname(__FILE__).dirname.expand_path
end # module Clockwork

require Clockwork::LIBDIR + "clockwork/expression"
require Clockwork::LIBDIR + "clockwork/assertion"
require Clockwork::LIBDIR + "clockwork/compound"
require Clockwork::LIBDIR + "clockwork/dsl"
require Clockwork::LIBDIR + "clockwork/core_ext"

def Clockwork
  yield(Clockwork::Dsl)
end

$LOAD_PATH << Clockwork::LIBDIR unless $LOAD_PATH.include?(Clockwork::LIBDIR)
