%team2int converts 3-letter team code to integer
function outint = team2int(teamname)
    teams = {'ATL' 'BOS' 'CHA' 'CHI' 'CLE' 'DAL' 'DEN' 'DET' 'GSW' 'HOU'...
        'IND' 'LAC' 'LAL' 'MEM' 'MIA' 'MIL' 'MIN' 'NJN' 'NOH' 'NYK'...
        'OKC' 'ORL' 'PHI' 'PHO' 'POR' 'SAC' 'SAS' 'TOR' 'UTA' 'WAS'};
    
    for i = 1:30
        if strcmp(teamname, teams(i))
            outint = i;
        end
    end
