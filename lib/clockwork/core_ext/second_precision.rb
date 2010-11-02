module Clockwork
  module CoreExt
    module SecondPrecision
      def usec
        nil
      end
    end # module SecondPrecision
  end # module CoreExt
end # module Clockwork

::DateTime.send(:include, Clockwork::CoreExt::SecondPrecision)
