module ClockworkMango
  module HolidayCollection
    def all_holidays
      @all_holidays ||= constants.map { |c| const_get(c) }
    end
    # has_a_holiday?
    # accepts a date
    # creates an array of holidays for the module
    # checks to see if the date is in the array
    def holiday?(date)
      all_holidays.any? { |holiday| holiday === date }
    end

    alias_method :include?, :holiday?
    alias_method :===,      :holiday?
  end

  module Holidays
    extend HolidayCollection

    class << self
      alias_method :all_regions, :all_holidays
    end

    def self.holiday?(date, region = nil)
      Array(region || all_regions).any? { |r| r.include?(date) }
    end
  end

end

Dir[File.dirname(__FILE__) + "/holidays/**/*.rb"].each { |lib| require lib }
