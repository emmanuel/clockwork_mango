require "clockwork" unless defined? Clockwork

module Clockwork

  module Holidays
    module Belize

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      BARON_BLISS_DAY = Clockwork{|c| c.march & c.mday(9)}
      #Good Friday, Holy Saturday, Easter Sunday and Easter Monday - variable dates
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      SOVEREIGNS_DAY = Clockwork{|c| c.may & c.mday(24)}
      COMMONWEALTH_DAY = Clockwork{|c| c.may & c.mday(24)}
      ST_GEORGES_CAYE_DAY = Clockwork{|c| c.september & c.mday(10)}
      INDEPENDENCE_DAY = Clockwork{|c| c.september & c.mday(21)}
      PAN_AMERICAN_DAY = Clockwork{|c| c.october & c.mday(12)}
      COLUMBUS_DAY = Clockwork{|c| c.october & c.mday(12)}
      GARIFUNA_SETTLEMENT_DAY = Clockwork{|c| c.november & c.mday(19)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|c| c.december & c.mday(26)}

    end
  end

end
