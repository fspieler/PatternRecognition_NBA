function features = norm_points_feature_extraction( raw_data, years )
    [~, num_years] = size(years);
    weights = [1 1 1 1 1];
    [~, num_weights] = size(weights);
    weights = weights/sum(weights); %normalize
    
    features = zeros( num_years, 30, 41, 3);
    %first feature is weighted normalized home points average
    %second feature is weighted normalized away points average
    %third element is a win for home team
    
    for year = years
        for team = 1:30
            feature_index = 1;
            for game = num_weights+1:82
                if( raw_data( year, team, game, stat2int('home') ) == 1)
                    feature = zeros(1,2);
                    for weight = 1:num_weights
                        feature(1) = feature(1) + weights(weight)...
                            * normalize_stat( raw_data, year, team, game-weight, stat2int('pts'));
                        [~, opp_team, opp_game] = opp_same_game(raw_data, year, team, game);
                        feature(2) = feature(2) + weights(weight)...
                            * normalize_stat( raw_data, year, opp_team, opp_game, stat2int('pts'));

                        features( year - min( years )+1, team, feature_index, 1 )...
                            = feature(1);

                        features( year - min( years )+1, team, feature_index, 2 )...
                            = feature(2);
                        features( year - min( years )+1, team, feature_index, 3 )...
                            = raw_data( year, team, game, stat2int('win'));
                    end
                    feature_index = feature_index+1;
                    if(feature_index > 42 )
                        error('feature_index too high');
                    end
                end
               
            end
            
        end
    end
