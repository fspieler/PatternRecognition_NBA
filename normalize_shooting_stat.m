function [std_devs, prev_games] = normalize_shooting_stat( raw_data, year, team_int, game_num)
    opp_team_int = raw_data(year, team_int, game_num, stat2int('opp'));
    date = raw_data(year, team_int, game_num, stat2int('date'));
    prev_games = zeros(82,2); %preallocate to handle worst case
     
    for i=1:82
        if raw_data( year, opp_team_int, i, stat2int('date') ) <= date
            prev_games(i,1) = raw_data( year, opp_team_int, i,...
                stat2int('OPPfg') ) / raw_data( year, opp_team_int, i,...
                stat2int('OPPfga') );
            prev_games(i,2) = raw_data( year, opp_team_int, i,...
                stat2int('fg') ) / raw_data( year, opp_team_int, i,...
                stat2int('fga') );
        else
            break
        end
    end
    
    stat_mean = mean(prev_games(1:i-1,1) - prev_games(1:i-1,2);
    stat_sdev = std(prev_games(1:i-1,1) - prev_games(1:i-1,2));
    comb_stat = raw_data( year, team_int, game_num, stat2int('fg') ) / raw_data( year, team_int, game_num, stat2int('fga'));
       
    if stat_sdev == 0 %first game of the season
        std_devs = 0;
    else
        std_devs = (comb_stat - stat_mean) / stat_sdev;
    end
