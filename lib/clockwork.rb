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
  $LOAD_PATH << Clockwork::LIBDIR unless $LOAD_PATH.include?(Clockwork::LIBDIR)
end # module Clockwork

require "clockwork/expression"
require "clockwork/assertion"
require "clockwork/compound"
require "clockwork/dsl"
require "clockwork/core_ext"

def Clockwork
  yield(Clockwork::Dsl)
end
