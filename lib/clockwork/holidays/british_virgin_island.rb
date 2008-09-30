require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module BritishVirginIslands


      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      LAVITY_STOUTTS_BIRTHDAY = Clockwork{|x| c.march & c.mday(5)}
      COMMONWEALTH_DAY = Clockwork{|x| c.march & c.mday(12)}
      #Good Friday - Friday before Easter (calculated according to Western Christian calendar)
      #Easter Monday
      #Whit Monday
      TERRITORY_DAY = Clockwork{|x| c.july & c.mday(1)}
      #1st Monday in August - Festival Monday
      #Tuesday after 1st Monday in August - Festival Tuesday
      #Wednesday after 1st Monday in August - Festival Wednesday
      SAINT_URSULAS_DAY = Clockwork{|x| c.october & c.mday(21)}
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|x| c.december & c.mday(26)}

    end
  end

end
