require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module DominicanRepublic


      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      DIA_DE_REYES = Clockwork{|x| c.january & c.mday(6)}
      DIA_DE_LA_ALTAGRACIA = Clockwork{|x| c.january & c.mday(21)}
      DUARTE_DAY = Clockwork{|x| c.january & c.mday(26)}
      INDEPENDENCE_DAY = Clockwork{|x| c.february & c.mday(27)}
      VIERNES_SANTO = Clockwork{|x| c.march & c.mday(21)}
      LABOR_DAY = Clockwork{|x| c.may & c.mday(1)}
      ASCENSION_DAY = Clockwork{|x| c.may & c.mday(1)}
      CORPUS_CHRISTI = Clockwork{|x| c.may & c.mday(22)}
      DIA_DE_LA_RESTAURACION = Clockwork{|x| c.august & c.mday(16)}
      DIA_DE_LAS_MERCEDES = Clockwork{|x| c.september & c.mday(24)}
      CONSTITUTION_DAY = Clockwork{|x| c.november & c.mday(6)}
      NAVIDAD = Clockwork{|x| c.december & c.mday(25)}

    end
  end
end
