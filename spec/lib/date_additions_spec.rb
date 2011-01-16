
require 'spec_helper'
require 'anniversary.rb'
describe "::Date" do
  
  context "Date.civil_with_missing_day_correction" do
    it "should handle a leap day jump" do
      Date.civil_with_missing_day_correction(2011, 2, 29).should == Date.civil(2011, 3, 1)
    end
    
    it "should handle a normal short month jump" do
      Date.civil_with_missing_day_correction(2011, 9, 31).should == Date.civil(2011, 10, 1)
    end
    
    it "should handle a multi-day jump in a leap year" do
      Date.civil_with_missing_day_correction(2012, 2, 31).should == Date.civil(2012, 3, 2)
    end
    
    it "should handle a multi-day jump in a non-leap year" do
      Date.civil_with_missing_day_correction(2011, 2, 31).should == Date.civil(2011, 3, 3)
    end
  end

  context "years_months_days_since" do
    def self.build_example(anniversary, subject, expected)
      eyd, emd, edd = *expected
      it "#{subject}.years_since(#{anniversary}) should give [#{eyd}, #{emd}, #{edd}]" do
        subject.years_months_days_since(anniversary).should == [eyd, emd, edd]
      end
    end
    
    def self.test_range(anniversary, last_date_to_test)
      raise "Dates are incompatible" if last_date_to_test < anniversary
      expected_year_diff = 0
      expected_month_diff = 0
      expected_day_diff = 0
      test_date = anniversary
      next_anniversary = ::Date.civil_with_missing_day_correction(test_date.year + 1, test_date.month, test_date.day)
      next_month = ::Date.civil(test_date.year, test_date.month, 1) >> 1
      next_monthiversary = ::Date.civil_with_missing_day_correction(next_month.year, next_month.month, test_date.day)
      
      while (test_date <= last_date_to_test) do
        build_example(anniversary, test_date, [expected_year_diff, expected_month_diff, expected_day_diff])
        expected_day_diff += 1
        test_date += 1
        if test_date == next_monthiversary
          next_month = ::Date.civil(test_date.year, test_date.month, 1) >> 1
          next_monthiversary = ::Date.civil_with_missing_day_correction(next_month.year, next_month.month, test_date.day)
          if test_date == next_anniversary
            next_anniversary = ::Date.civil_with_missing_day_correction(test_date.year + 1, test_date.month, test_date.day)
            expected_year_diff += 1
            expected_month_diff = 0
          else
            expected_month_diff += 1
          end
          expected_day_diff = 0
        end
      end
    end
    
    it "should give zeroes for the same date" do
      anniversary = ::Date.civil(2001, 6, 1)
      target = ::Date.civil(2001, 6, 1)
      target.years_months_days_since(anniversary).should == [0, 0, 0]          
    end
    
    it "should handle a case where the date is in the next calendar month, but before the montiversary" do
       anniversary = ::Date.civil(2001, 6, 15)
       target = ::Date.civil(2001, 7, 1)
       target.years_months_days_since(anniversary).should == [0, 0, 16]          
     end
    
     it "should handle a case where the date is one month after an anniversary on the first of the month" do
        anniversary = ::Date.civil(2001, 6, 1)
        target = ::Date.civil(2001, 7, 1)
        target.years_months_days_since(anniversary).should == [0, 1, 0]          
      end
    
      it "should handle a case where the date is new years day after the anniversary" do
         anniversary = ::Date.civil(2001, 6, 1)
         target = ::Date.civil(2002, 1, 1)
         target.years_months_days_since(anniversary).should == [0, 7, 0]          
       end
    
     
     test_range( ::Date.civil(2000,6,1), ::Date.civil(2010,8,31))
     test_range( ::Date.civil(2000, 6, 15), ::Date.civil(2010,8,31))
  
  end
end
