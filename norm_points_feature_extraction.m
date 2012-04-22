function features = norm_points_feature_extraction( raw_data, years, weights )
    [~, num_years] = size(years);
    
    [~, num_weights] = size(weights);
    weights = weights/sum(weights); %normalize
    
    features = zeros( num_years, 30, 41, 3);
    %first feature is weighted normalized home predictive-score 
    %second feature is weighted normalized away predictive-score
    %third element is a win for home team (1 for win, -1 for loss, 0 for empty!)
    
    for year = years
        for team = 1:30
            feature_index = 1;
            for game = num_weights*2:82
                if( raw_data( year, team, game, stat2int('home') ) == 1)
                    feature = zeros(1,2);
                    [~, opp_team, opp_game] = opp_same_game(raw_data, year, team, game);
                    
                    for weight = 1:num_weights
                        feature(1) = feature(1) + weights(weight)...
                            * normalize_both_stat( raw_data, year, team, game-weight, stat2int('pts'));
                        
                        feature(2) = feature(2) + weights(weight)...
                            * normalize_both_stat( raw_data, year, opp_team, opp_game-weight, stat2int('pts'));

                        features( year - min( years )+1, team, feature_index, 1 )...
                            = feature(1);

                        features( year - min( years )+1, team, feature_index, 2 )...
                            = feature(2);
                        features( year - min( years )+1, team, feature_index, 3 )...
                            = 2*raw_data( year, team, game, stat2int('win'))-1;
                        
                        if feature(1) > 5 || feature(2) > 5
                            year, team, game, opp_team, opp_game
                        end
                    end
                    feature_index = feature_index+1;
                    if(feature_index > 42 )
                        error('feature_index too high');
                    end
                end   
            end
        end
    end
