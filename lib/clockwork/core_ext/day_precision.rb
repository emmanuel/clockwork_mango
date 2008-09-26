module Clockwork
  module CoreExt
    module DayPrecision
      def self.included(base)
        base.module_eval do
          # TODO: make this conditional so it doesn't blow up if it gets 
          #   included in unanticipated places
          alias_method :original_hour, :hour # if instance_methods.include?(:hour)
          alias_method :original_min,  :min  # if instance_methods.include?(:min)
          alias_method :original_sec,  :sec  # if instance_methods.include?(:sec)
          
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
          # TODO: make this conditional so it doesn't blow up if it gets 
          #   included in unanticipated places
          alias_method :hour, :original_hour # if instance_methods.include?(:original_hour)
          alias_method :min,  :original_min  # if instance_methods.include?(:original_min)
          alias_method :sec,  :original_sec  # if instance_methods.include?(:original_sec)
        end
      end
    end
  end # module CoreExt
end # module Clockwork
