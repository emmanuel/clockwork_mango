require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Austria
      extend HolidayCollection

      NEW_YEARS_DAY      = Clockwork { january(1) }
      EPIPHANY           = Clockwork { january(6) }
      #Easter Monday
      LABOUR_DAY         = Clockwork { may(1) }
      #Ascension Day - * The fortieth day after Easter Sunday.
      #Whit Sunday - * (Pfingsten) Pentecost Descent of the Holy Ghost upon the Apostles,fifty days after the Resurrection of Christ.
      #Corpus Christi - * First Holy Eucharist Last supper. Thursday after Trinity Sunday.
      ASSUMPTION_OF_MARY = Clockwork { august(15) }
      AUSTRIAN_NATIONAL_DAY_DAY_OF_THE_DECLARATION_OF_NEUTRALITY = Clockwork { october(26) }
      ALL_SAINTS_DAY        = Clockwork { november(1) }
      IMMACULATE_CONCEPTION = Clockwork { december(8) }
      CHRISTMAS             = Clockwork { december(25) }
      ST_STEPHENS_DAY       = Clockwork { december(26) }

      #Movable Holidays (*)

    end
  end
end
