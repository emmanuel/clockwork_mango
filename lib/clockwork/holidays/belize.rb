require "clockwork" unless defined? Clockwork

module Clockwork

  module Holidays
    module Belize

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      BARON_BLISS_DAY = Clockwork{|x| c.march & c.mday(9)}
      #Good Friday, Holy Saturday, Easter Sunday and Easter Monday - variable dates
      LABOUR_DAY = Clockwork{|x| c.may & c.mday(1)}
      SOVEREIGNS_DAY = Clockwork{|x| c.may & c.mday(24)}
      COMMONWEALTH_DAY = Clockwork{|x| c.may & c.mday(24)}
      ST_GEORGES_CAYE_DAY = Clockwork{|x| c.september & c.mday(10)}
      INDEPENDENCE_DAY = Clockwork{|x| c.september & c.mday(21)}
      PAN_AMERICAN_DAY = Clockwork{|x| c.october & c.mday(12)}
      COLUMBUS_DAY = Clockwork{|x| c.october & c.mday(12)}
      GARIFUNA_SETTLEMENT_DAY = Clockwork{|x| c.november & c.mday(19)}
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|x| c.december & c.mday(26)}

    end
  end

end
