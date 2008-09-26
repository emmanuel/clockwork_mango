require "pathname"

module Clockwork
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 1
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].join('.')
    self
  end # module VERSION
  
  LIBDIR = Pathname(__FILE__).dirname.expand_path + "clockwork"
end # module Clockwork

require Clockwork::LIBDIR + "expression"
require Clockwork::LIBDIR + "assertion"
require Clockwork::LIBDIR + "compound"
require Clockwork::LIBDIR + "dsl"
require Clockwork::LIBDIR + "core_ext"

def Clockwork
  yield(Clockwork::Dsl)
end
