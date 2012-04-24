function features = srt_feature_extraction( raw_data, years, weights )
    [~, num_years] = size(years);
    
    [~, num_weights] = size(weights);
    for i = 1:3
        weights(i,:) = weights(i,:)/sum(weights(i,:)); %normalize
    end
    % TODO: weights handling
    
    features = zeros( num_years, 30, 41, 5);
    %first feature is weighted normalized home shooting percentage metric
    %second feature is weighted normalized away shooting percentage metric
    %third feature is weighted normalized rebounding difference metric
    %fourth feature is weighted normalized turnover difference metric
    %fifth element is a win for home team (-1 for loss, 0 for empty!)
    
    for year = years
        for team = 1:30
            feature_index = 1;
            for game = num_weights*2:82
                if( raw_data( year, team, game, stat2int('home') ) == 1)
                    feature = zeros(1,2);
                    [~, opp_team, opp_game] = opp_same_game(raw_data, year, team, game);
                    
                    temp_rhome = 0;
                    temp_raway = 0;
                    temp_shome = 0;
                    temp_saway = 0;
                    temp_thome = 0;
                    temp_taway = 0;
                    
                    for weight = 1:num_weights
                   
