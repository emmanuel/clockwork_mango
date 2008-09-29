require "clockwork"
module Holidays
  module UnitiedStates
    NEW_YEARS_DAY = Clockwork {|c| c.january & c.mday(1) } # January 1
    MARTIN_LUTHER_KING_JR_DAY = Clockwork {|c| c.january & c.monday & c.wday_in_month(3) } # January 21 (3rd Monday of January, traditionally Jan. 15)
    GROUNDHOG_DAY = Clockwork {|c| c.february & c.mday(2) } # February 2
    SUPER_BOWL_SUNDAY = Clockwork {|c| c.february & c.sunday & c.wday_in_month(1)} # February 3 (currently the first Sunday of February)
    VALENTINES_DAY = Clockwork {|c| c.february & c.mday(14) } # February 14
    PRESIDENTS_DAY = Clockwork {|c| c.february & c.monday & c.wday_in_month(3)} # February 18 (officially Washington's Birthday; 3rd Monday of February, traditionally Feb. 22)
    ST_PATRICKS_DAY = Clockwork {|c| c.march & c.mday(17)  } # March 17
    APRIL_FOOLS_DAY = Clockwork {|c| c.april & c.mday(1)} # April 1
    PATRIOTS_DAYMARATHON_MONDAY = Clockwork {|c| c.april & c.monday & c.wday_in_month(3) } # April 21 (New England and Wisconsin only) (3rd Monday of April)
    EARTH_DAY = Clockwork {|c| c.april & c.mday(22) } # April 22

    ARBOR_DAY = Clockwork {|c| c.april & c.mday(25) }
    CINCO_DE_MAYO = Clockwork {|c| c.may & c.mday(5) } # (Mexican holiday often observed in US)
    MOTHERS_DAY = Clockwork {|c| c.may & c.sunday & c.wday_in_month(2) }  #(2nd Sunday of may),
    MEMORIAL_DAY = Clockwork {|c| c.may & c.monday & c.wday_in_month(4) } # (last Monday of may, traditionally may 30)
    FLAG_DAY = Clockwork {|c| c.june & c.mday(14) }
    FATHERS_DAY = Clockwork {|c| c.june & c.sunday & c.wday_in_month(3) }  #(3rd Sunday of june)
    SUMMER_SOLSTICE = Clockwork {|c| c.june & c.mday(21) } # (based on sun)
    INDEPENDENCE_DAY = Clockwork {|c| c.july & c.mday(4) }
    LABOR_DAY = Clockwork {|c| c.september & c.monday & c.wday_in_month(1) }  #(first Monday of September)
    COLUMBUS_DAY = Clockwork {|c| c.october & c.monday & c.wday_in_month(2) } # (2nd Monday of october, traditionally Oct. 12)
    LAST_DAY_OF_SUKKOT = Clockwork {|c| c.october & c.mday(20) } # (Jewish)
    MISCHIEF_NIGHT = Clockwork {|c| c.october & c.mday(30) }
    HALLOWEEN = Clockwork {|c| c.october & c.mday(31) }
    ALL_SAINTS_DAY_DAY_OF_THE_DEAD = Clockwork {|c| c.november & c.mday(1) }  #(Mexico)
    ELECTION_DAY = Clockwork {|c| c.november & c.tuesday & c.wday_in_month(1) } # (Tuesday after the first Monday of november)
    VETERANS_DAY = Clockwork {|c| c.november & c.mday(11) }
    THANKSGIVING = Clockwork {|c| c.november & c.thursday & c.wday_in_month(4) } # (4th Thursday of november)
    BLACK_FRIDAY = Clockwork {|c| c.november & c.friday & c.wday_in_month(4) } # (Friday after Thanksgiving Day)
    PEARL_HARBOR_REMEMBRANCE_DAY = Clockwork {|c| c.december & c.mday(7) }
    WINTER_SOLSTICE = Clockwork {|c| c.december & c.mday(21) } # (based on sun)
    CHRISTMAS_EVE = Clockwork {|c| c.december & c.mday(24) } # (Christian)
    CHRISTMAS_DAY = Clockwork {|c| c.december & c.mday(25) } # (Christian)
    NEW_YEARS_EVE = Clockwork {|c| c.december & c.mday(31) }
    FIRST_DAY_OF_KWANZAA = Clockwork {|c| c.december & c.mday(26) }

    # (Kwanzaa is celebrated until January 1, 2009)


    #moveable
    ASH_WEDNESDAY = Clockwork {|c| c.february & c.mday(6) } # February 6 (Christian; moveable based on Easter)
    VERNAL_EQUINOX = Clockwork {|c| } # March 20 (based on sun), Lailatul-Qadr (Islamic; moveable, based on lunar calendar)
    GOOD_FRIDAY = Clockwork {|c| } # March 21 (Christian; Friday before Easter)
    EASTER_SUNDAY = Clockwork {|c| } # March 23 (Christian; moveable; Sunday after first full moon during spring)
    EASTER_MONDAY = Clockwork {|c| } # March 24 (Christian; Monday after Easter)
    PALM_SUNDAY = Clockwork {|c| } # March 16 (Christian; Sunday before Easter)
    FIRST_DAY_OF_PASSOVER = Clockwork {|c| } # April 20 (Jewish; moveable based on Jewish calendar)
    LAST_DAY_OF_PASSOVER = Clockwork {|c| } # April 27 (Jewish; moveable, based on Jewish Calendar)
    #Pentecost Sunday (Christian; 49 days after Easter)
    FIRST_DAY_OF_RAMADAN = Clockwork {|c| } # September 2 (Islamic, moveable based on Lunar calendar)
    OCT_1_ROSH_HASHANAH = Clockwork {|c| } # September 30 (Jewish; moveable, based on Jewish calendar)
    EIDALFITRDAY_AFTER_THE_END_OF_RAMADAN = Clockwork {|c| } # October 2 (Islamic, moveable, based on lunar calendar)
    YOM_KIPPUR = Clockwork {|c| } # October 9 (Jewish, moveable, 9 days after first day of Rosh Hashanah), Leif Erikson Day
    FIRST_DAY_OF_SUKKOT = Clockwork {|c| } # October 14 (Jewish; moveable, 14 days after Rosh Hashanaah)
    SIMCHAT_TORAH = Clockwork {|c| } # October 22 (Jewish; moveable, 22 days after Rosh Hashanah)
    FIRST_DAY_OF_HANNUKKAH = Clockwork {|c| } # December 22 (Jewish; moveable, based on Jewish calendar)
    LAST_DAY_OF_HANNUKKAH = Clockwork {|c| } # December 29 (Jewish; moveable, based on Jewish Calendar)
  end
end
