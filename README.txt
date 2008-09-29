= Clockwork

* http://clockwork.rubyforge.org

== DESCRIPTION:

Briefly, Clockwork simplifies the process of describing many types of 
recurrence: think Cron expressions in plain English, but that's not all!

Clockwork provides an implementation of Temporal Expressions, (roughly) as 
described by Martin Fowler in his paper "Recurring Events for Calendars" 
(http://martinfowler.com/apsupp/recurring.pdf). The implementation itself 
differs significantly from the one that Fowler describes there.

== FEATURES/PROBLEMS:

* Describe event recurrence with a simple DSL.
* Simple, clean, well-specified (TODO) codebase.
* Unified implementation for recurrence, Precisioned Dates, and 
  Date/DateTime/Time Ranges.

== SYNOPSIS:

The main interface is the Clockwork method, which accepts a block 
that defines the returned Clockwork::Expression object. The most basic 
Expression matches on a single attribute (an Assertion). Assertion builder 
methods are named after the attribute they assert, and accept integers or 
ranges.

  mondays      = Clockwork { |c| c.wday(1) }
  weekdays     = Clockwork { |c| c.wday(1..5) }
  nine_to_five = Clockwork { |c| c.hour(9..17) }
  this_year    = Clockwork { |c| c.year(Time.now.year) }

Single value assertions and ranges are not terribly useful on their own, so 
they can be composed into (arbitrarily complex) expressions using the set 
operations &, |, and -. 
 * Intersections (created with "&") match when _all_ of their members match. 
 * Unions (created with "|") match when _any_ of their members match.
 * Differences (created with "-") match when the first Expression (receiver) 
   matches, and the second expression (argument) does not.

  now = Time.now
  # this breaks on Jan 1... but you get the picture
  yesterday = Clockwork { |c| c.year(now.year) & c.yday(now.yday - 1) }
  work_time = Clockwork { |c| c.hour(9..17) & c.wday(1..5) }
  not_work  = Clockwork do |c|
    c.wday(0) | c.wday(6) | (c.wday(1..5) - c.hour(9..17))
  end

Named shortcuts for weekdays and months are provided (currently only singular 
forms, but plurals are coming soon).

  mon_wed_fri = Clockwork { |c| c.mondays | c.wednesdays | c.fridays }
  christmas   = Clockwork { |c| c.december & c.mday(25) }

Some additional methods are available to deal with particular types of dates: 
#yweek (week of the year, similar to DateTime#cweek), #wday_in_month (ordinal 
occurrence of weekday in month, eg. Thanksgiving in the US: the 3rd thursday 
of November).

  seattle_art_walk = Clockwork { |c| c.thursday & c.wday_in_month(1) }
  thanksgiving = Clockwork { |c| c.november & c.thursday & c.wday_in_month(3) }

Times of day and time ranges can be specified with the #at and #from methods, 
which accept hours, minutes and optionally seconds as arrays of integers in 
24 hour format (hour, minute[, second]):

  work_week    = Clockwork { |c| c.from([9,15]..[17,45]) & c.wday(1..5) }
  back_to_work = Clockwork { |c| c.at([9,15]) & c.mondays }

As mentioned, expressions can be composed as needed, but be aware of 
precedence when building complex expressions:

  class_time = Clockwork do |c|
    ((c.mondays | c.wednesdays | c.thursdays) & c.from([19,00]..[21,30])) |
      (c.sundays & c.from([12,00]..[13,30]))
  end

So, what do you do with these objects? Clockwork::Expression objects provide 
a #=== method to test inclusion of a Date, Time, DateTime, or other similar 
object. Any object that quacks like a Time object can be tested: attributes 
#year, #month, #mday, #hour, #min, #sec, and #usec, as well as the previously 
mentioned additional attributes can be tested for. 

One possible usage is a scheduler:

  loop do
    case Time.now
    when christmas    : # give presents
    when thanksgiving : # eat turkey
    when my_birthday  : # receive cards
    when class_time   : # wake up from my nap
    else
      # nothing happening right now
    end
    
    # you need Extlib or ActiveSupport for this to work
    sleep 15.minutes
  end

Remember that expressions (Christmas, Thanksgiving, my birthday, etc.) will 
report true for every Time object that they match; in the above example, 
the "when christmas" clause would fire repeatedly throughout the day 
(whenever tested). You have to take any necessary steps to prevent multiple 
executions of your code.

Clockwork includes a module of expressions for commonly observed holidays 
(fairly United States-centric, at this point) to get you started nice and easy. 
The module is called Clockwork::Holidays, and it's a separate require:

  require 'clockwork'
  require 'clockwork/holidays'
  
  case Date.today
  when Clockwork::Holidays::UnitedStates::MOTHERS_DAY : # call your mom
  when Clockwork::Holidays::UnitedStates::FATHERS_DAY : # call your dad
  when Clockwork::Holidays::UnitedStates::EARTH_DAY : # thank the planet
  when Clockwork::Holidays::UnitedStates::LABOR_DAY : # complain if you're at work
  when Clockwork::Holidays::UnitedStates::ELECTION_DAY : # cast your vote
  end


== REQUIREMENTS:

* Ruby. Only tested on MRI 1.8.6 and 1.8.7.

== INSTALL:

* sudo gem install clockwork

== LICENSE:

(The MIT License)

Copyright (c) 2008 Emmanuel Gomez

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
