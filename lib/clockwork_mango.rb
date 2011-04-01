lib = File.dirname(__FILE__)
$LOAD_PATH << lib unless $LOAD_PATH.include?(lib)

require "clockwork_mango/version"
require "clockwork_mango/core_ext"
require "clockwork_mango/predicate"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"
require "clockwork_mango/occurrence_solver"
require "clockwork_mango/dumper"
require "clockwork_mango/loader"
require "clockwork_mango/dsl"
