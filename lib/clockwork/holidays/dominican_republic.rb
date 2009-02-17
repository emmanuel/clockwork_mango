require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module DominicanRepublic


      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      DIA_DE_REYES = Clockwork{|c| c.january & c.mday(6)}
      DIA_DE_LA_ALTAGRACIA = Clockwork{|c| c.january & c.mday(21)}
      DUARTE_DAY = Clockwork{|c| c.january & c.mday(26)}
      INDEPENDENCE_DAY = Clockwork{|c| c.february & c.mday(27)}
      VIERNES_SANTO = Clockwork{|c| c.march & c.mday(21)}
      LABOR_DAY = Clockwork{|c| c.may & c.mday(1)}
      ASCENSION_DAY = Clockwork{|c| c.may & c.mday(1)}
      CORPUS_CHRISTI = Clockwork{|c| c.may & c.mday(22)}
      DIA_DE_LA_RESTAURACION = Clockwork{|c| c.august & c.mday(16)}
      DIA_DE_LAS_MERCEDES = Clockwork{|c| c.september & c.mday(24)}
      CONSTITUTION_DAY = Clockwork{|c| c.november & c.mday(6)}
      NAVIDAD = Clockwork{|c| c.december & c.mday(25)}
      extend HolidayMixin

    end
  end
end
