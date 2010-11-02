require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Austria
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      EPIPHANY = Clockwork{|c| c.january & c.mday(6)}
      #Easter Monday
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      #Ascension Day - * The fortieth day after Easter Sunday.
      #Whit Sunday - * (Pfingsten) Pentecost Descent of the Holy Ghost upon the Apostles,fifty days after the Resurrection of Christ.
      #Corpus Christi - * First Holy Eucharist Last supper. Thursday after Trinity Sunday.
      ASSUMPTION_OF_MARY = Clockwork{|c| c.august & c.mday(15)}
      AUSTRIAN_NATIONAL_DAY_DAY_OF_THE_DECLARATION_OF_NEUTRALITY = Clockwork{|c| c.october & c.mday(26)}
      ALL_SAINTS_DAY = Clockwork{|c| c.november & c.mday(1)}
      IMMACULATE_CONCEPTION = Clockwork{|c| c.december & c.mday(8)}
      CHRISTMAS = Clockwork{|c| c.december & c.mday(25)}
      ST_STEPHENS_DAY = Clockwork{|c| c.december & c.mday(26)}

      #Movable Holidays (*)

    end
  end
end
