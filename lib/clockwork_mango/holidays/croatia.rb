require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Croatia
      extend HolidayCollection

      NEW_YEARS_DAY                         = Clockwork { january(1) }
      NOVA_GODINA                           = Clockwork { january(1) }
      EPIPHANY                              = Clockwork { january(6) }
      BOGOJAVLJENJE                         = Clockwork { january(6) }
      #variable date - Easter Sunday and Monday - Uskrs i Uskrsni ponedjeljak
      LABOUR_DAY                            = Clockwork { may(1) }
      MEUNARODNI_PRAZNIK_RADA               = Clockwork { may(1) }
      #CORPUS_CHRISTI__TIJELOVO             = Clockwork { days post easter(60) }
      ANTIFASCIST_STRUGGLE_DAY              = Clockwork { june(22) }
      DAN_ANTIFAISTIKE_BORBE                = Clockwork { june(22) }
      STATEHOOD_DAY_CROATIA                 = Clockwork { june(25) }
      DAN_DRAVNOSTI                         = Clockwork { june(25) }
      VICTORY_AND_HOMELAND_THANKSGIVING_DAY = Clockwork { august(5) }
      DAN_POBJEDE_I_DOMOVINSKE_ZAHVALNOSTI  = Clockwork { august(5) }
      ASSUMPTION_OF_MARY                    = Clockwork { august(15) }
      VELIKA_GOSPA                          = Clockwork { august(15) }
      INDEPENDENCE_DAY                      = Clockwork { october(8) }
      DAN_NEZAVISNOSTI                      = Clockwork { october(8) }
      ALL_SAINTS_DAY                        = Clockwork { november(1) }
      DAN_SVIH_SVETIH                       = Clockwork { november(1) }
      CHRISTMAS                             = Clockwork { december(25) }
      BOI                                   = Clockwork { december(25) }
      SAINT_STEPHEN                         = Clockwork { december(26) }
      SVETI_STJEPAN                         = Clockwork { december(26) }

    end
  end
end
