require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Colombia
      extend HolidayCollection

      NEW_YEARS_DAY                  = Clockwork { january(1) }
      EPIPHANY                       = Clockwork { january(8) }
      SAINT_JOSEPHS_DAY              = Clockwork { march(19) }
      #Holy Thursday, and Good Friday - variable dates
      LABOUR_DAY                     = Clockwork { may(1) }
      ASCENSION_DAY                  = Clockwork { may(21) }
      #Corpus Christi Day - variable dates (Thursday after Trinity Sunday)
      #        o 22 May 2008, 11 June 2009, 3 June 2010; 23 June 2011, 7 June 2012, 30 May 2013, 19 June 2014, 4 June 2015, 26 May 2016, 15 June 2017, 31 May 2018, 20 June 2019, 11 June 2020, 3 June 2021, 16 June 2022
      #Sacred Heart Day - variable dates (19 days after Pentecost)
      FEAST_OF_SAINTS_PETER_AND_PAUL = Clockwork { july(2) }
      INDEPENDENCE_DAY               = Clockwork { july(20) }
      BATTLE_OF_BOYACAS_DAY          = Clockwork { august(7) }
      ASSUMPTION_DAY                 = Clockwork { august(15) }
      COLUMBUS_DAY                   = Clockwork { october(12) }
      ALL_SAINTS_DAY                 = Clockwork { november(5) }
      IMMACULATE_CONCEPTION_DAY      = Clockwork { december(8) }
      CHRISTMAS_DAY                  = Clockwork { december(24) }

    end
  end
end
