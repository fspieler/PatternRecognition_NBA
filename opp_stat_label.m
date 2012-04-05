%this function converts an integer stat label to the corresponding opponent
%integer stat label. For example, the int corresponding to 'fg' is
%converted to the int corresponding to 'OPPfg'

%MAGIC NUMBERS 14 and 35 correspond to 35 columns in raw_data and 14 column
%difference between team's stats and opp's stats
function opp_stat_int = opp_stat_label(stat_int)
    if stat_int + 14 > 35
        opp_stat_int = stat_int - 14;
    else
        opp_stat_int = stat_int + 14;
    end
    
