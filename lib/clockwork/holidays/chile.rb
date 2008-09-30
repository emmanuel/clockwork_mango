require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Chile

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      #March/April - Good Friday
      #March/April - Easter
      LABOUR_DAY = Clockwork{|x| c.may & c.mday(1)}
      NAVY_DAY = Clockwork{|x| c.may & c.mday(21)}
      #June - Corpus Christi
      #June 27 - Feast of Saints Peter and Paul
      ASSUMPTION_OF_MARY = Clockwork{|x| c.august & c.mday(15)}
      INDEPENDENCE_DAY = Clockwork{|x| c.september & c.mday(18)}
      GLORIES_OF_THE_ARMY_DAY = Clockwork{|x| c.september & c.mday(19)}
      #October 12 - Columbus Day
      ALL_SAINTS = Clockwork{|x| c.november & c.mday(1)}
      IMMACULATE_CONCEPTION = Clockwork{|x| c.december & c.mday(8)}
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}

    end
  end

end
