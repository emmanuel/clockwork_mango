module Clockwork
  module CoreExt
    module DayPrecision
      def self.included(base)
        base.module_eval do
          alias_method :original_hour, :hour
          alias_method :original_min,  :min
          alias_method :original_sec,  :sec
          
          def hour
            nil
          end
          
          alias_method :min,  :hour
          alias_method :sec,  :hour
          alias_method :usec, :hour
          
          public :hour
          public :min
          public :sec
          public :usec
        end
      end
    end # module DayPrecision
    
    module DayPrecisionRemover
      def self.included(base)
        base.module_eval do
          alias_method :hour, :original_hour
          alias_method :min,  :original_min
          alias_method :sec,  :original_sec
        end
      end
    end
  end # module CoreExt
end # module Clockwork
