function std_devs = normalize_both_stat( raw_data, year, team_int, game_num, stat_int)
    opp_team_int = raw_data(year, team_int, game_num, stat2int('opp'));
    date = raw_data(year, team_int, game_num, stat2int('date'));
    prev_games = zeros(82,1); %preallocate to handle worst case
     
    for i=1:82
        if raw_data( year, opp_team_int, i, stat2int('date') ) <= date
            prev_games(i) = raw_data( year, opp_team_int, i,...
                opp_stat_label(stat_int) ) - raw_data( year, opp_team_int, i, stat_int);
        else
            break
        end
    end
    
    stat_mean = mean(prev_games(1:i-1));
    stat_sdev = std(prev_games(1:i-1));
    stat = raw_data( year, team_int, game_num, stat_int) - raw_data( year, team_int, game_num, opp_stat_label(stat_int));
    
    if stat_sdev == 0 %first game of the season
        std_devs = 0;
    else
        std_devs = (stat - stat_mean) / stat_sdev;
    end