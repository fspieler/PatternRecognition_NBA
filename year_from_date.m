function year = year_from_date(date)
    year = floor(date / 10000);
    
    if mod(date, 10000) > 900 %later than September 
        year = year + 1;
    end
