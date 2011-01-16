# Anniversary calculate years, months and days between two dates
http://talklikeaduck.denhaven2.com/2011/01/16/they-say-its-your-birthday

Say you want to show the age of a person on a particular date, say for a medical report document.

Since my birthday is the eighth of December, I'm Plenty-Nine years, one month, and eight days old today, which happens to be the sixteenth of January.

Computing that correctly is trickier than it appears at first.

First I thought this was just a matter of taking the integer part of dividing the difference between the dates by 365.25, and so on.  Think again.

Then I thought there must be some open source solution to this, but every google search I tried for something like "age in years months and days" came back with the same results as if I'd searched for age in years months OR days, which is a horse of a different color.

Your age in years, is actually the number of birthdays you have had, or to use a more generic term for the yearly recurrence of an event anniversaries, then you count the months between your last birthday anniversary and your last 'monthiversary', then the days since then.

There are complications since some months are shorter than others, so geting this right is a bit tricky.  Hence Anniversary

## Installation

  gem install anniversary
  
## Documentation

  basically this gem adds a few methods to Ruby's Date class. The key one is years_months_days_since which returns an array comprising the years months and days since the argument.
  
  For details [see the rdoc](http://rdoc.info/github/rubyredrick/anniversary/master/Date)
  
  For more on the mofivation [see my blog](http://talklikeaduck.denhaven2.com/2011/01/16/they-say-its-your-birthday)