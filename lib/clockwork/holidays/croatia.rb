require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Croatia


      NEW_YEARS_DAY  = Clockwork{|c| c.january & c.mday(1)}
      NOVA_GODINA = Clockwork{|c| c.january & c.mday(1)}
      EPIPHANY  = Clockwork{|c| c.january & c.mday(6)}
      BOGOJAVLJENJE = Clockwork{|c| c.january & c.mday(6)}
      #variable date - Easter Sunday and Monday - Uskrs i Uskrsni ponedjeljak
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      MEUNARODNI_PRAZNIK_RADA = Clockwork{|c| c.may & c.mday(1)}
      #CORPUS_CHRISTI__TIJELOVO = Clockwork{|c| c.days post easter & c.mday(60)}
      ANTIFASCIST_STRUGGLE_DAY = Clockwork{|c| c.june & c.mday(22)}
      DAN_ANTIFAISTIKE_BORBE = Clockwork{|c| c.june & c.mday(22)}
      STATEHOOD_DAY_CROATIA  = Clockwork{|c| c.june & c.mday(25)}
      DAN_DRAVNOSTI = Clockwork{|c| c.june & c.mday(25)}
      VICTORY_AND_HOMELAND_THANKSGIVING_DAY  = Clockwork{|c| c.august & c.mday(5)}
      DAN_POBJEDE_I_DOMOVINSKE_ZAHVALNOSTI = Clockwork{|c| c.august & c.mday(5)}
      ASSUMPTION_OF_MARY = Clockwork{|c| c.august & c.mday(15)}
      VELIKA_GOSPA = Clockwork{|c| c.august & c.mday(15)}
      INDEPENDENCE_DAY = Clockwork{|c| c.october & c.mday(8)}
      DAN_NEZAVISNOSTI = Clockwork{|c| c.october & c.mday(8)}
      ALL_SAINTS_DAY = Clockwork{|c| c.november & c.mday(1)}
      DAN_SVIH_SVETIH = Clockwork{|c| c.november & c.mday(1)}
      CHRISTMAS = Clockwork{|c| c.december & c.mday(25)}
      BOI = Clockwork{|c| c.december & c.mday(25)}
      SAINT_STEPHEN = Clockwork{|c| c.december & c.mday(26)}
      SVETI_STJEPAN = Clockwork{|c| c.december & c.mday(26)}

    end
  end

end
