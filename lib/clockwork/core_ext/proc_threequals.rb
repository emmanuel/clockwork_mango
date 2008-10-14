module Clockwork
  module CoreExt
    module ProcThreequals
      def ===(*arguments)
        self.call(*arguments)
      end
    end
  end
end
