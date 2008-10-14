module Clockwork
  class ProcAssertion < Expression
    def initialize(proc=nil, &block)
      @value = proc || block
    end

    def ===(rval)
      @value === rval
    end
  end
end
