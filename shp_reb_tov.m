%% init

clear all

%% load data from csvs into raw_data

    raw_data = zeros(2012-2004,30,82,35);

    for year=2005:1:2012
        S = urlread([ 'file:///U:\My Documents\MATLAB\fspieler-PatternRecognition_NBA-b719940\'...
            num2str(year) '_data.csv'] );
        C = textscan(S ,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d',...
            'delimiter',';');
    
        [m ~] = size(C{1}(:));
        for i = 1:m
            for j = 1:35
                raw_data(year-2004, char(C{1}(i)), (C{2}(i)), j) = C{j}(i);
            end
        end
    end
    
%% create training and testing data w/feature extraction... sit tight, this will take a while
    %using norm_points_feature_extraction.m, which uses a state based on
    %normalizing results from each teams past games (as determined by
    %weights). Uses margin of victory. 
    
    clear train_features train_years test_features test_years weights
    
    %years must be between 1 and 8, and consecutive for either matrix
    train_years = 1:6;
    test_years = 7;
    
    %weights(1) corresponds to the previous game, weights(2) corresponds to
    %the game before that, etc.
    
    weights = [1 1 1 1 1 1 ];
    
    train_features = norm_points_feature_extraction( raw_data, ...
        train_years, weights);
    test_features = norm_points_feature_extraction( raw_data, ...
        test_years, weights);
    
    %% normalize_percent_bothteams_stat test
    norm_matrix = zeros(30,82);
    
    for team = 1:30
        for game = 1:82
            norm_matrix(team, game) = normalize_percent_bothteams_stat( raw_data, 1, team, game, stat2int('tov'));
            
        end
        int2team(team), mean(norm_matrix(team,:)), std(norm_matrix(team,:))
    end
    
   
