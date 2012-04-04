%%init

clear all

%%load data from csvs into raw_data

    raw_data = zeros(2012-2004,30,35,82);

    for year=2005:1:2012
        S = urlread([ 'file:///U:\My Documents\MATLAB\fspieler-PatternRecognition_NBA-b719940\'...
            num2str(year) '_data.csv'] );
        C = textscan(S ,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d',...
            'delimiter',';');
    
        [m n] = size(C{1}(:));
        for i = 1:m
            for j = 1:35
                raw_data(year-2004, char(C{1}(i)), j,(C{2}(i))) = C{j}(i);
            end
        end
    end

%%
