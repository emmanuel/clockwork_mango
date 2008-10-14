require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module FederationOfBosniaAndHerzegovina

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      #Easter
      MAY_DAY = Clockwork{|c| c.may & c.mday(1)}
      #Christmas

    end
  end

end
