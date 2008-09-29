require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module InternationalObservance
      GLOBAL_FAMILY_DAY = Clockwork{|c| c.january & c.mday(1)} #  formerly One Day of Peace and Sharing, recognized by the UN
      WORLD_DAY_FOR_WAR_ORPHANS_ = Clockwork{|c| c.january & c.mday(6)} #  initiated by (S.O.S Enfants En Detresse - www.soseed.org by Stephen N. Kinuthia)
      INTERNATIONAL_DAY_FOR_PEACE_IN_KENYA = Clockwork{|c| c.january & c.mday(11)} #  January 11, 2008. Recent events in the country left Kenyans in fear of their future. The stalemate between the political leaders has created opportunity for destructive forces, and organized militia, which have risen to kill innocent people (more than 450 killed, thousands injured and over 250,000 displaced - initiated by (Kenya Welfare Foundation & Kenya Development Network and Consortium)
      INTERNATIONAL_HOLOCAUST_REMEMBRANCE_DAY = Clockwork{|c| c.january & c.mday(27)} #  recognized by the UN
      DATA_PROTECTION_DAY = Clockwork{|c| c.january & c.mday(28)} #  recognized by the Council of Europe [1]
      WORLD_WETLANDS_DAY = Clockwork{|c| c.february & c.mday(2)}
      WORLD_CANCER_DAY = Clockwork{|c| c.february & c.mday(4)}
      INTERNATIONAL_TACKY_EMAIL_FORMATTING_DAY = Clockwork{|c| c.february & c.mday(4)}
      DARWIN_DAY = Clockwork{|c| c.february & c.mday(12)}
      VALENTINES_DAY = Clockwork{|c| c.february & c.mday(14)}
      WORLD_DAY_OF_SOCIAL_JUSTICE = Clockwork{|c| c.february & c.mday(20)} #  recognized by the UN
      INTERNATIONAL_MOTHER_LANGUAGE_DAY = Clockwork{|c| c.february & c.mday(21)} #  recognized by the UN
      WORLD_DAY_OF_THE_FIGHT_AGAINST_SEXUAL_EXPLOITATION = Clockwork{|c| c.march & c.mday(4)} #  ONG GIPF (site (French))
      UNITED_NATIONS_DAY_FOR_WOMENS_RIGHTS_AND_INTERNATIONAL_PEACE = Clockwork{|c| c.march & c.mday(8)} #  recognized by the UN
      INTERNATIONAL_WOMENS_DAY = Clockwork{|c| c.march & c.mday(8)} #  recognized by the UN
      WORLD_CONSUMER_RIGHTS_DAY = Clockwork{|c| c.march & c.mday(15)}
      INTERNATIONAL_DAY_OF_THE_FRANCOPHONIE = Clockwork{|c| c.march & c.mday(20)} #  (site (French))
      WORLD_SLEEP_DAY = Clockwork{|c| c.march & c.mday(21)}
      INTERNATIONAL_DAY_FOR_THE_ELIMINATION_OF_RACIAL_DISCRIMINATION = Clockwork{|c| c.march & c.mday(21)} #  recognized by the UN
      WORLD_DAY_FOR_WATER = Clockwork{|c| c.march & c.mday(22)} #  recognized by the UN
      WORLD_METEOROLOGICAL_DAY = Clockwork{|c| c.march & c.mday(23)} #  recognized by the UN
      WORLD_TUBERCULOSIS_DAY = Clockwork{|c| c.march & c.mday(24)} #  recognized by the UN
      INTERNATIONAL_DAY_OF_REMEMBRANCE_OF_THE_VICTIMS_OF_SLAVERY_AND_THE_TRANSATLANTIC_SLAVE_TRADE = Clockwork{|c| c.march & c.mday(25)} #  recognized by the UN
      WORLD_THEATRE_DAY = Clockwork{|c| c.march & c.mday(27)}
      WORLD_WEAR_ODD_SOCKS_DAY = Clockwork{|c| c.march & c.mday(27)}
      WORLD_AUTISM_AWARENESS_DAY = Clockwork{|c| c.april & c.mday(2)} #  recognized by the UN
      INTERNATIONAL_DAY_FOR_MINE_AWARENESS_AND_ASSISTANCE_IN_MINE_ACTION = Clockwork{|c| c.april & c.mday(4)} #  recognized by the UN
      WORLD_HEALTH_DAY = Clockwork{|c| c.april & c.mday(7)} #  recognized by the UN
      INTERNATIONAL_DAY_OF_REFLECTION_ON_THE_GENOCIDE_IN_RWANDA = Clockwork{|c| c.april & c.mday(7)} #  recognized by the UN
      EARTH_DAY = Clockwork{|c| c.april & c.mday(22)}
      WORLD_BOOK_AND_COPYRIGHT_DAY = Clockwork{|c| c.april & c.mday(23)} #  recognized by the UN
      INTERNATIONAL_NOSE_PICKING_DAY = Clockwork{|c| c.april & c.mday(23)}
      WORLD_MALARIA_DAY = Clockwork{|c| c.april & c.mday(25)} #  recognized by the WHO
      WORLD_INTELLECTUAL_PROPERTY_DAY = Clockwork{|c| c.april & c.mday(26)} #  recognized by the UN
      INTERNATIONAL_WORKERS_MEMORIAL_DAY = Clockwork{|c| c.april & c.mday(28)}
      WORLD_DANCE_DAY = Clockwork{|c| c.april & c.mday(29)}
      MAY_DAY_ = Clockwork{|c| c.may & c.mday(1)}
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      WORLD_PRESS_FREEDOM_DAY = Clockwork{|c| c.may & c.mday(3)} #  recognized by the UN
      INTERNATIONAL_FIREFIGHTERS_DAY = Clockwork{|c| c.may & c.mday(4)}
      WORLD_RED_CROSS_RED_CRESCENT_DAY = Clockwork{|c| c.may & c.mday(8)}
      TIME_OF_REMEMBRANCE_AND_RECONCILIATION_FOR_THOSE_WHO_LOST_THEIR_LIVES_DURING_THE_SECOND_WORLD_WAR = Clockwork{|c| c.may & c.mday(9)} #  recognized by the UN
      INTERNATIONAL_NURSES_DAY = Clockwork{|c| c.may & c.mday(12)}
      INTERNATIONAL_DAY_OF_FAMILIES = Clockwork{|c| c.may & c.mday(15)} #  recognized by the UN
      WORLD_TELECOMMUNICATION_DAY = Clockwork{|c| c.may & c.mday(17)} #  recognized by the UN
      WORLD_DAY_FOR_CULTURAL_DIVERSITY_FOR_DIALOGUE_AND_DEVELOPMENT = Clockwork{|c| c.may & c.mday(21)} #  recognized by the UN
      INTERNATIONAL_DAY_FOR_BIOLOGICAL_DIVERSITY = Clockwork{|c| c.may & c.mday(22)} #  recognized by the UN
      INTERNATIONAL_DAY_OF_UNITED_NATIONS_PEACEKEEPERS = Clockwork{|c| c.may & c.mday(29)} #  recognized by the UN
      WORLD_NO_TOBACCO_DAY = Clockwork{|c| c.may & c.mday(31)} #  recognized by the UN
      INTERNATIONAL_CHILDRENS_DAY = Clockwork{|c| c.june & c.mday(1)}
      INTERNATIONAL_DAY_OF_INNOCENT_CHILDREN_VICTIMS_OF_AGGRESSION = Clockwork{|c| c.june & c.mday(4)} #  recognized by the UN
      WORLD_ENVIRONMENT_DAY = Clockwork{|c| c.june & c.mday(5)} #  recognized by the UN
      WORLD_BRAIN_TUMOUR_DAY = Clockwork{|c| c.june & c.mday(8)}
      WORLD_OCEAN_DAY = Clockwork{|c| c.june & c.mday(8)}
      WORLD_DAY_AGAINST_CHILD_LABOUR = Clockwork{|c| c.june & c.mday(12)}
      WORLD_BLOOD_DONOR_DAY = Clockwork{|c| c.june & c.mday(14)} #  recognized by the UN
      WORLD_DAY_TO_COMBAT_DESERTIFICATION_AND_DROUGHT = Clockwork{|c| c.june & c.mday(17)} #  recognized by the UN
      INTERNATIONAL_PICNIC_DAY = Clockwork{|c| c.june & c.mday(18)}
      WORLD_REFUGEE_DAY = Clockwork{|c| c.june & c.mday(20)} #  recognized by the UN
      WORLD_MUSIC_DAY = Clockwork{|c| c.june & c.mday(21)}
      UNITED_NATIONS_PUBLIC_SERVICE_DAY = Clockwork{|c| c.june & c.mday(23)} #  recognized by the UN
      INTERNATIONAL_DAY_AGAINST_DRUG_ABUSE_AND_ILLICIT_TRAFFICKING = Clockwork{|c| c.june & c.mday(26)} #  recognized by the UN
      INTERNATIONAL_DAY_IN_SUPPORT_OF_VICTIMS_OF_TORTURE = Clockwork{|c| c.june & c.mday(26)} #  recognized by the UN
      WORLD_POPULATION_DAY = Clockwork{|c| c.july & c.mday(11)} #  recognized by the UN
      INTERNATIONAL_DAY_OF_THE_WORLDS_INDIGENOUS_PEOPLE = Clockwork{|c| c.august & c.mday(9)} #  recognized by the UN[3][4]
      INTERNATIONAL_YOUTH_DAY = Clockwork{|c| c.august & c.mday(12)} #  recognized by the UN
      LEFT_HANDERS_DAY = Clockwork{|c| c.august & c.mday(13)}
      INTERNATIONAL_DAY_FOR_THE_REMEMBRANCE_OF_THE_SLAVE_TRADE_AND_ITS_ABOLITION = Clockwork{|c| c.august & c.mday(23)} #  recognized by the UN
      NAMIBIA_DAY = Clockwork{|c| c.august & c.mday(26)} #  recognized by the UN
      ACCORDING_TO_HOYLE_DAY = Clockwork{|c| c.august & c.mday(29)}
      INTERNATIONAL_LITERACY_DAY = Clockwork{|c| c.september & c.mday(8)} #  recognized by the UN
      WORLD_FIRST_AID_DAY = Clockwork{|c| c.september & c.mday(11)}
      INTERNATIONAL_DAY_OF_DEMOCRACY = Clockwork{|c| c.september & c.mday(15)} #  recognized by the UN
      INTERNATIONAL_DAY_FOR_THE_PRESERVATION_OF_THE_OZONE_LAYER = Clockwork{|c| c.september & c.mday(16)} #  recognized by the UN
      INTERNATIONAL_TALK_LIKE_A_PIRATE_DAY = Clockwork{|c| c.september & c.mday(19)}
      INTERNATIONAL_DAY_OF_PEACE = Clockwork{|c| c.september & c.mday(21)} #  recognized by the UN
      WORLD_ALZHEIMERS_DAY = Clockwork{|c| c.september & c.mday(21)}
      WORLD_CAR_FREE_DAYS = Clockwork{|c| c.september & c.mday(22)}
      INTERNATIONAL_GRAB_HAND_DAY_NOT_RECOGNISED_BY_UN = Clockwork{|c| c.september & c.mday(25)} #  but only those in the GIS Industry, and all associated IT Disciplines.
      EUROPEAN_DAY_OF_LANGUAGES = Clockwork{|c| c.september & c.mday(26)}
      WORLD_TOURISM_DAY = Clockwork{|c| c.september & c.mday(27)}
      RIGHT_TO_KNOW_DAY_ = Clockwork{|c| c.september & c.mday(28)}
      WORLD_RABIES_DAY = Clockwork{|c| c.september & c.mday(28)}
      INTERNATIONAL_DAY_OF_OLDER_PERSONS = Clockwork{|c| c.october & c.mday(1)} #  recognized by the UN
      WORLD_VEGETARIAN_DAY = Clockwork{|c| c.october & c.mday(1)}
      INTERNATIONAL_DAY_OF_NONVIOLENCE = Clockwork{|c| c.october & c.mday(2)} #  recognized by the UN, observed on M.K. Gandhi's birthday
      WORLD_ANIMAL_DAY = Clockwork{|c| c.october & c.mday(4)}
      WORLD_TEACHERS_DAY = Clockwork{|c| c.october & c.mday(5)}
      WORLD_HOSPICE_AND_PALLIATIVE_CARE_DAY = Clockwork{|c| c.october & c.mday(6)}
      WORLD_HUMANITARIAN_ACTION_DAY = Clockwork{|c| c.october & c.mday(8)}
      WORLD_POST_DAY = Clockwork{|c| c.october & c.mday(9)} #  recognized by the UN
      WORLD_MENTAL_HEALTH_DAY = Clockwork{|c| c.october & c.mday(10)} #  recognized by the UN
      WORLD_DAY_AGAINST_DEATH_PENALTY = Clockwork{|c| c.october & c.mday(10)} #  recognized by the WCADP
      WORLD_STANDARDS_DAY = Clockwork{|c| c.october & c.mday(14)}
      INTERNATIONAL_DAY_OF_RURAL_WOMEN = Clockwork{|c| c.october & c.mday(15)} #  recognized by the UN
      FOUNDATION_OF_THE_BLACK_PANTHERS_DAY = Clockwork{|c| c.october & c.mday(15)}
      WORLD_FOOD_DAY = Clockwork{|c| c.october & c.mday(16)} #  recognized by the UN
      INTERNATIONAL_DAY_FOR_THE_ERADICATION_OF_POVERTY = Clockwork{|c| c.october & c.mday(17)} #  recognized by the UN
      UNITED_NATIONS_DAY = Clockwork{|c| c.october & c.mday(24)} #  recognized by the UN
      WORLD_DEVELOPMENT_INFORMATION_DAY = Clockwork{|c| c.october & c.mday(24)} #  recognized by the UN
      WORLD_VEGAN_DAY = Clockwork{|c| c.november & c.mday(1)}
      INTERNATIONAL_DAY_FOR_PREVENTING_THE_EXPLOITATION_OF_THE_ENVIRONMENT_IN_WAR_AND_ARMED_CONFLICT = Clockwork{|c| c.november & c.mday(6)} #  recognized by the UN
      WORLD_FREEDOM_DAY = Clockwork{|c| c.november & c.mday(9)}
      WORLD_DIABETES_DAY = Clockwork{|c| c.november & c.mday(14)} #  recognized by the UN
      INTERNATIONAL_DAY_FOR_TOLERANCE = Clockwork{|c| c.november & c.mday(16)} #  recognized by the UN
      INTERNATIONAL_STUDENTS_DAY = Clockwork{|c| c.november & c.mday(17)}
      WORLD_TOILET_DAY = Clockwork{|c| c.november & c.mday(19)}
      AFRICA_INDUSTRIALIZATION_DAY = Clockwork{|c| c.november & c.mday(20)} #  recognized by the UN
      UNIVERSAL_CHILDRENS_DAY = Clockwork{|c| c.november & c.mday(20)} #  recognized by the UN
      WORLD_HELLO_DAY = Clockwork{|c| c.november & c.mday(21)}
      WORLD_TELEVISION_DAY = Clockwork{|c| c.november & c.mday(21)} #  recognized by the UN
      INTERNATIONAL_DAY_FOR_THE_ELIMINATION_OF_VIOLENCE_AGAINST_WOMEN = Clockwork{|c| c.november & c.mday(25)} #  recognized by the UN
      INTERNATIONAL_DAY_OF_SOLIDARITY_WITH_THE_PALESTINIAN_PEOPLE = Clockwork{|c| c.november & c.mday(29)} #  recognized by the UN
      WORLD_AIDS_DAY = Clockwork{|c| c.december & c.mday(1)} #  recognized by the UN
      ROMANIA_NATIONAL_DAY = Clockwork{|c| c.december & c.mday(1)}
      INTERNATIONAL_DAY_FOR_THE_ABOLITION_OF_SLAVERY = Clockwork{|c| c.december & c.mday(2)} #  recognized by the UN
      INTERNATIONAL_DAY_OF_DISABLED_PERSONS = Clockwork{|c| c.december & c.mday(3)} #  recognized by the UN
      INTERNATIONAL_VOLUNTEER_DAY_FOR_ECONOMIC_AND_SOCIAL_DEVELOPMENT = Clockwork{|c| c.december & c.mday(5)} #  recognized by the UN
      INTERNATIONAL_CIVIL_AVIATION_DAY = Clockwork{|c| c.december & c.mday(7)} #  recognized by the UN
      THE_INTERNATIONAL_DAY_AGAINST_CORRUPTION = Clockwork{|c| c.december & c.mday(9)} #  recognized by the UN
      HUMAN_RIGHTS_DAY = Clockwork{|c| c.december & c.mday(10)} #  recognized by the UN
      INTERNATIONAL_MOUNTAIN_DAY = Clockwork{|c| c.december & c.mday(11)} #  recognized by the UN
      INTERNATIONAL_MIGRANTS_DAY = Clockwork{|c| c.december & c.mday(18)} #  recognized by the UN
      UNITED_NATIONS_DAY_FOR_SOUTHSOUTH_COOPERATION = Clockwork{|c| c.december & c.mday(19)} #  recognized by the UN
      INTERNATIONAL_HUMAN_SOLIDARITY_DAY = Clockwork{|c| c.december & c.mday(20)} #  recognized by the UN


      INTERNATIONAL_PEACE_WEEK = Clockwork { |c| c.september & c.mweek(4) } #* 4th week of September -
      WORLD_MARITIME_DAY = Clockwork { |c| c.september & c.mweek(-1) } #* During last week of September - , recognized by the UN
      WORLD_HABITAT_DAY = Clockwork { |c| c.october & c.monday & c.wday_in_month(1) }#* First Monday of October - , recognized by the UN
      WORLD_DAY_OF_REMEMBRANCE_FOR_ROAD_TRAFFIC_VICTIMS = Clockwork { |c| c.november & c.sunday & c.wday_in_month(3) } #* Third Sunday of November - , recognized by the UN
      INTERNATIONAL_DAY_FOR_NATURAL_DISASTER_REDUCTION = Clockwork { |c| c.october & c.wednesday & c.wday_in_month(2) } #* Second Wednesday of October - , recognized by the UN
      INTERNATIONAL_DAY_OF_COOPERATIVES = Clockwork { |c| c.july & c.saturday & c.wday_in_month(1) } #* 1st Saturday of July - , recognized by the UN
      WORLD_ASTHMA_DAY = Clockwork { |c| c.may & c.tuesday & c.wday_in_month(1) } #* 1st Tuesday of May -
      WORLD_FAIR_TRADE_DAY = Clockwork { |c| c.may & c.saturday & c.wday_in_month(2) } #* 2nd Saturday of May -

    end
  end
end