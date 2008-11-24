module Clockwork
  class ProcAssertion < Expression
    def initialize(proc=nil, &block)
      @value = proc || block
    end

    def ===(*rval)
      @value.call(*rval)
    end
  end
end
