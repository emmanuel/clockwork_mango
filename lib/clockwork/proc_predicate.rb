# Procs are not serializable, so this is a ticking time bomb
module Clockwork
  class ProcPredicate < Predicate
    def initialize(proc=nil, &block)
      @value = proc || block
    end

    def ===(*rval)
      @value.call(*rval)
    end
  end
end
