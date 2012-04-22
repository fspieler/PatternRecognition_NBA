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
    
   % train_features = norm_points_feature_extraction( raw_data, ...
    %    train_years, weights);
    test_features = norm_points_feature_extraction( raw_data, ...
        test_years, weights);

%% cleanup train data
clear train_data
train_data = [];
tyears = train_years - min(train_years) + 1;

for year = tyears
    for team = 1:30
        for game = 1:41
            if train_features( year, team, game, 3) ~= 0
                train_data = [train_data; train_features( year, team, game, 1) train_features( year, team, game, 2) train_features( year, team, game, 3)];
            end
        end
    end
end

%% cleanup test data
clear test_data
test_data = [];
tyears = test_years - min(test_years) + 1;

for year = tyears
    for team = 1:30
        for game = 1:41
            if test_features( year, team, game, 3) ~= 0
                test_data = [test_data; test_features( year, team, game, 1) test_features( year, team, game, 2) test_features( year, team, game, 3)];
            end
        end
    end
end

%% Bayesian classifier
[m ~] = size(train_data);
[n ~] = size(test_data);
nb = NaiveBayes.fit(train_data(:,1:2),train_data(:,3),'Distribution','normal');
display(nb)
% training error rate
train_err = 0;
train_cpre = predict(nb,train_data(:,1:2));
for i = 1:m
    if train_cpre(i) ~= train_data(i,3)
        train_err = train_err + 1;
    end
end

train_error_rate = train_err /(m+n)


test_err = 0;
test_cpre = predict(nb,test_data(:,1:2));
for i = 1:n
    if test_cpre(i) ~= test_data(i,3)
        test_err = test_err + 1;
    end
end

test_error_rate = test_err / n
    
    %% plot winners against losers
  clear train_winners train_losers
  train_winners = [];
  train_losers = [];

for year = train_years;
    for team=1:30
      for game = 1:41
          if train_features(year, team, game, 3) == 1
              train_winners = [train_winners; train_features(year,team,game,1) train_features(year,team,game,2)];
          end
      end
    end
end

for year = train_years;   
  for team=1:30
      for game = 1:41
          if train_features(year, team, game, 3) == -1
              train_losers = [train_losers; train_features(year,team,game,1) train_features(year,team,game,2)];
          end
      end
  end
end
    x = -4:4;
    
    close all
    hold on
    %xlim([-4 4]);
    %ylim([-4 4]);
    axis square
    scatter( winners(:,2), winners(:,1),'.','r');
    scatter( losers(:,2), losers(:,1),'.','g');
    %plot(x,2*x)
