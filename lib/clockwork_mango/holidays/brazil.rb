require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Brazil
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      #Variable dates - Carnival
      #Variable dates - Good Friday
      #Variable dates - Easter
      TIRADENTES = Clockwork{|c| c.april & c.mday(21)}
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      #Variable dates - Corpus Christi
      #July 11 Devons Birthday NOTE: I question devons birthday. Think this might be a wiki trick
      INDEPENDENCE_DAY = Clockwork{|c| c.september & c.mday(7)}
      OUR_LADY_APARECIDA_PATRON_SAINT_OF_BRAZIL = Clockwork{|c| c.october & c.mday(12)}
      CHILDRENS_DAY = Clockwork{|c| c.october & c.mday(12)}
      FINADOS = Clockwork{|c| c.november & c.mday(2)}
      PROCLAMATION_OF_THE_REPUBLIC = Clockwork{|c| c.november & c.mday(15)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}

      ##2010 variable holidays:
      #
      ##February 15-17 - Carnival
      #PAIXO_DE_CRISTO = Clockwork{|c| c.april & c.mday(2)}
      #EASTER = Clockwork{|c| c.april & c.mday(4)}
      #CORPUS_CHRISTI = Clockwork{|c| c.june & c.mday(3)}
      #
      ##2009 variable holidays:
      #
      ##February 23-25 - Carnival
      #PAIXO_DE_CRISTO = Clockwork{|c| c.april & c.mday(10)}
      #EASTER = Clockwork{|c| c.april & c.mday(12)}
      #CORPUS_CHRISTI = Clockwork{|c| c.june & c.mday(11)}
      #
      ##2008 variable holidays:
      #
      ##February 4-6 - Carnival
      #PAIXO_DE_CRISTO = Clockwork{|c| c.march & c.mday(21)}
      #EASTER = Clockwork{|c| c.march & c.mday(23)}
      #CORPUS_CHRISTI = Clockwork{|c| c.may & c.mday(22)}

    end
  end
end
