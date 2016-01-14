%% Get Practice data and classify

disp('Started Test_Practice');
clear Class_Multi_General Posterior

test_path_name = 'Practice_dataset/Practice_';

% Get the number of testing samples:
total_test_samples = 50;

% And the number of features is:
total_features = size(Train_data_Audio_normalized, 2);
% 
% 
t = templateEnsemble('Bag',30,'Tree','type','classification');
Class_Multi_General{1} = fitcecoc(Train_data_Power_normalized,Train_data_Power_Class,'Learners',t,'FitPosterior',1,'Coding', 'binarycomplete');

t = templateEnsemble('Bag',30,'Tree','type','classification');
Class_Multi_General{2} = fitcecoc(Train_data_Audio_normalized,Train_data_Audio_Class,'Learners',t,'FitPosterior',1,'Coding', 'binarycomplete');

t = templateEnsemble('Bag',30,'Tree','type','classification');
Class_Multi_General{3} = fitcecoc(Train_data_normalized,Train_data_class,'Learners',t,'FitPosterior',1,'Coding', 'binarycomplete');
 
% test_Type = zeros(50,1);

%% Step: read ENF with no median, to see if power or audio
for sample_n = 1:total_test_samples
    p_name = [test_path_name num2str(sample_n) '.wav'];
    [test_recording, ~] = audioread(p_name);
    [~,~,~,P] = spectrogram(test_recording);
    
    test_Type(sample_n) = max(max(P))<100;
    
    test_ENF(sample_n,:) = extract_ENF(test_recording, apply_median, moving_median_width, Fs, ...
                                Time_Step, Percent_Overlap, Padding_Factor, filter_half_size);
end

test_Audio_ENF = test_ENF(test_Type==1);
test_Power_ENF = test_ENF(test_Type==0);


%% Extract Features
parfor entry_counter = 1:total_test_samples
    freq = test_ENF(entry_counter,:);
    [features_array(entry_counter, :)] = extract_Features( freq );
end


order_test_data = linspace(1,50,50);

actual_grid_classes = [1 8 3 6 6 2 7  9 10 4 ...
                       1 6 2 4 3 9 10 10 1 5 ...
                       8 2 2 1 4 3 7  10 7 2 ... 9 17 18 28 47
                       4 4 3 8 7 5 1  9  8 9 ...
                       5 8 5 3 6 6 10 7  5 9];

actual_grid_classes_audio = actual_grid_classes(test_Type==1);
features_array_Audio = features_array(test_Type==1,:);
features_Audio_order = order_test_data(test_Type==1);

actual_grid_classes_power = actual_grid_classes(test_Type==0);
features_array_Power = features_array(test_Type==0,:);
features_Power_order = order_test_data(test_Type==0);



parfor feature = 1:total_features
    features_array_Audio(:,feature) = ...
        ( features_array_Audio(:,feature) - normalize_mean_param_Audio(feature) ) .* ...
        (100 / normalize_max_param_Audio(feature)); 
   
    features_array_Power(:,feature) = ...
        ( features_array_Power(:,feature) - normalize_mean_param_Power(feature) ) .* ...
        (100 / normalize_max_param_Power(feature)); 
    
    features_array2(:,feature) = ...
        ( features_array(:,feature) - normalize_mean_param(feature) ) .* ...
        (100 / normalize_max_param(feature)); 
end

parfor i=1:total_test_samples
   
    if( sum(features_Audio_order==i)==1)
        features_array(i,:) = features_array_Audio(features_Audio_order==i,:);
    else
        features_array(i,:) = features_array_Power(features_Power_order==i,:);
    end
end

n_guesses_grid = size(Class_Multi_General, 2);
Guess_Grid_Ensemble = zeros(total_test_samples, n_guesses_grid);
Guess_Grid_Final = zeros(1, total_test_samples);
for sample_n = 1:total_test_samples
            
            [label,~,~,Posterior(2,sample_n,:)] = predict( Class_Multi_General{2}, features_array(sample_n,:) );
            Guess_Grid_Ensemble(sample_n, 2) = label;
            
        [label,~,~,Posterior(1,sample_n,:)] = predict( Class_Multi_General{1}, features_array(sample_n,:) );
            Guess_Grid_Ensemble(sample_n, 1) = label;
            
            [label,~,~,Posterior(3,sample_n,:)] = predict( Class_Multi_General{3}, features_array2(sample_n,:) );
            Guess_Grid_Ensemble(sample_n, 3) = label;
end


for sample_n = 1:total_test_samples
    parfor g = 1:9
%          Posterior_Sum(sample_n,g) = ( Posterior(1,sample_n,g) + Posterior(2,sample_n,g) )/2;
Posterior_Sum(sample_n,g) = Posterior(1,sample_n,g) ;
    end
    [Max_Prob_Value_1(sample_n), Posterior_Max_Grid_1(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_1(sample_n)) = -1;
    [Max_Prob_Value_2(sample_n), Posterior_Max_Grid_2(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_2(sample_n)) = -2;
    [Max_Prob_Value_3(sample_n), Posterior_Max_Grid_3(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_3(sample_n)) = -3;
    [Max_Prob_Value_4(sample_n), Posterior_Max_Grid_4(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_4(sample_n)) = -4;
    [Max_Prob_Value_5(sample_n), Posterior_Max_Grid_5(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_5(sample_n)) = -5;
    [Max_Prob_Value_6(sample_n), Posterior_Max_Grid_6(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_6(sample_n)) = -6;
    [Max_Prob_Value_7(sample_n), Posterior_Max_Grid_7(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_7(sample_n)) = -7;
    [Max_Prob_Value_8(sample_n), Posterior_Max_Grid_8(sample_n)] = max( Posterior_Sum(sample_n,:) );
end

for i =1:4
    acc_p(i) =  sum( eval(['Posterior_Max_Grid_' num2str(i)]) == actual_grid_classes )*2 ;
    disp([ 'Prob Rank ' num2str(i) ' has acc = ' num2str(acc_p(i)) '%']);
end
disp(['Total being: ' num2str(sum(acc_p)) '%']);