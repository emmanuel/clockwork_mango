require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module FederationOfBosniaAndHerzegovina

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      #Easter
      MAY_DAY = Clockwork{|x| c.may & c.mday(1)}
      #Christmas

    end
  end

end
