function [year, opp_team, opp_game] = opp_same_game( raw_data, year, team, game )
    opp_team = raw_data( year, team, game, stat2int('opp') );
    date = raw_data( year, team, game, stat2int('date') );
    
    opp_game = 0;
    
    for i = 1:82
        if( raw_data( year, opp_team, i, stat2int('date') ) == date )
            opp_game = i;
            break;
        end
    end
