require "clockwork_mango"

module ClockworkMango
  module Holidays
    module DominicanRepublic
      extend HolidayCollection

      NEW_YEARS_DAY          = Clockwork { january(1) }
      DIA_DE_REYES           = Clockwork { january(6) }
      DIA_DE_LA_ALTAGRACIA   = Clockwork { january(21) }
      DUARTE_DAY             = Clockwork { january(26) }
      INDEPENDENCE_DAY       = Clockwork { february(27) }
      VIERNES_SANTO          = Clockwork { march(21) }
      LABOR_DAY              = Clockwork { may(1) }
      ASCENSION_DAY          = Clockwork { may(1) }
      CORPUS_CHRISTI         = Clockwork { may(22) }
      DIA_DE_LA_RESTAURACION = Clockwork { august(16) }
      DIA_DE_LAS_MERCEDES    = Clockwork { september(24) }
      CONSTITUTION_DAY       = Clockwork { november(6) }
      NAVIDAD                = Clockwork { december(25) }

    end
  end
end
