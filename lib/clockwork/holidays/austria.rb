require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Austria

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      EPIPHANY = Clockwork{|x| c.january & c.mday(6)}
      #Easter Monday
      LABOUR_DAY = Clockwork{|x| c.may & c.mday(1)}
      #Ascension Day - * The fortieth day after Easter Sunday.
      #Whit Sunday - * (Pfingsten) Pentecost Descent of the Holy Ghost upon the Apostles,fifty days after the Resurrection of Christ.
      #Corpus Christi - * First Holy Eucharist Last supper. Thursday after Trinity Sunday.
      ASSUMPTION_OF_MARY = Clockwork{|x| c.august & c.mday(15)}
      AUSTRIAN_NATIONAL_DAY_DAY_OF_THE_DECLARATION_OF_NEUTRALITY = Clockwork{|x| c.october & c.mday(26)}
      ALL_SAINTS_DAY = Clockwork{|x| c.november & c.mday(1)}
      IMMACULATE_CONCEPTION = Clockwork{|x| c.december & c.mday(8)}
      CHRISTMAS = Clockwork{|x| c.december & c.mday(25)}
      ST_STEPHENS_DAY = Clockwork{|x| c.december & c.mday(26)}

      #Movable Holidays (*)

    end
  end
end
