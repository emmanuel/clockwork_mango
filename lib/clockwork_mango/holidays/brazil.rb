require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Brazil
      extend HolidayCollection

      NEW_YEARS_DAY                             = Clockwork { january(1) }
      #Variable dates - Carnival
      #Variable dates - Good Friday
      #Variable dates - Easter
      TIRADENTES                                = Clockwork { april(21) }
      LABOUR_DAY                                = Clockwork { may(1) }
      #Variable dates - Corpus Christi
      #July 11 Devons Birthday NOTE: I question devons birthday. Think this might be a wiki trick
      INDEPENDENCE_DAY                          = Clockwork { september(7) }
      OUR_LADY_APARECIDA_PATRON_SAINT_OF_BRAZIL = Clockwork { october(12) }
      CHILDRENS_DAY                             = Clockwork { october(12) }
      FINADOS                                   = Clockwork { november(2) }
      PROCLAMATION_OF_THE_REPUBLIC              = Clockwork { november(15) }
      CHRISTMAS_DAY                             = Clockwork { december(25) }

      ##2010 variable holidays:
      #
      ##February 15-17 - Carnival
      #PAIXO_DE_CRISTO = Clockwork { april(2) }
      #EASTER          = Clockwork { april(4) }
      #CORPUS_CHRISTI  = Clockwork { june(3) }
      #
      ##2009 variable holidays:
      #
      ##February 23-25 - Carnival
      #PAIXO_DE_CRISTO = Clockwork { april(10) }
      #EASTER          = Clockwork { april(12) }
      #CORPUS_CHRISTI  = Clockwork { june(11) }
      #
      ##2008 variable holidays:
      #
      ##February 4-6 - Carnival
      #PAIXO_DE_CRISTO = Clockwork { march(21) }
      #EASTER          = Clockwork { march(23) }
      #CORPUS_CHRISTI  = Clockwork { may(22) }

    end
  end
end
