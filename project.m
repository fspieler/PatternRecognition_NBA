function raw_data = main(~)

    %raw_data = zeros(2012-2004,30,82,35,100);

    for year=2005:1:2012
        year
        S = urlread([ 'file:///U:\My Documents\MATLAB\fspieler-PatternRecognition_NBA-b719940\'...
            num2str(year) '_data.csv'] );
        C = textscan(S ,'%s %d %d %s %s %s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d',...
            'delimiter',';');
    
        raw_data(1, 1, 1, 1) = char(C{1,1}(1,1))
        
        [m n] = size(C{1}(:));
        for i = 1:m
            for j = 1:35
                raw_data(year-2004, team2int(char(C{1,1}(i,1))), (C{2,1}(i,1)), j) = C{j,1}(i,1);
            end
        end
    end

    %team-code testing
    for i = 1:30
        int2team(i)
        team2int(int2team(i))
    end
    

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

%int2team converts integer to 3-letter team code
function teamname = int2team(int)
    teams = {'ATL' 'BOS' 'CHA' 'CHI' 'CLE' 'DAL' 'DEN' 'DET' 'GSW' 'HOU'...
        'IND' 'LAC' 'LAL' 'MEM' 'MIA' 'MIL' 'MIN' 'NJN' 'NOH' 'NYK'...
        'OKC' 'ORL' 'PHI' 'PHO' 'POR' 'SAC' 'SAS' 'TOR' 'UTA' 'WAS'};
    teamname = teams(int);



