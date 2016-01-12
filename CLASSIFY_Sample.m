

% 1) Load all the saved trained classifiers into the code AND parameters to
% normalize
% 2) Call this script

%NEED:
% all power/audio/general AND all binary power/audio/general
% normalize_max_param
% normalize_mean_param
% normalize_max_param_NOMEDIAN
% normalize_mean_param_NOMEDIAN




% Get the path where the testing recordings are:
test_path_name = 'Practice_dataset/Practice_';

% Get the number of testing samples:
total_test_samples = 50;

% And the number of features is:
total_features = 27;







%% Step: read ENF with no median, to see if power or audio
for sample_n = 1:total_test_samples
    p_name = [test_path_name num2str(sample_n) '.wav'];
    [test_recording, ~] = audioread(p_name);
    freq_peaks_test_NOMEDIAN(sample_n,:) = extract_ENF(test_recording,0,999); %moving_median_width
end


%% Step: get features of the ENF WITH median filtering, and normalize features
% apply a moving median filter
moving_median_width = 20;
for sample_n = 1:total_test_samples
    freq_vs_time = freq_peaks_test_NOMEDIAN(sample_n,:);

    half_width = moving_median_width/2;
    for index = half_width : size(freq_vs_time,2)-half_width
        freq_vs_time_median(index-half_width+1) = median( freq_vs_time( index-half_width+1 : index+half_width ) );
    end

    if size(freq_vs_time_median,2) > 5
        result_freq_vs_time = freq_vs_time_median;
    else
        result_freq_vs_time = freq_vs_time;
        disp('xx check extract_ENF median window xx');
    end

    freq_peaks_test_MEDIAN(sample_n,:) = result_freq_vs_time;
%     figure; plot( freq_peaks_test_MEDIAN(sample_n,:) );
end
freq_peaks_test_MEDIAN = freq_peaks_test_NOMEDIAN;

    feature_mean_array                 = zeros(1,total_test_samples);
    feature_variance_array             = zeros(1,total_test_samples);
    feature_range_array                = zeros(1,total_test_samples);
    feature_approx_variance_array      = zeros(1,total_test_samples);
    feature_detailed_variance_L1_array = zeros(1,total_test_samples);
    feature_detailed_variance_L2_array = zeros(1,total_test_samples);
    feature_detailed_variance_L3_array = zeros(1,total_test_samples);
    feature_detailed_variance_L4_array = zeros(1,total_test_samples);
    feature_detailed_variance_L5_array = zeros(1,total_test_samples);
    feature_detailed_variance_L6_array = zeros(1,total_test_samples);
    feature_detailed_variance_L7_array = zeros(1,total_test_samples);
    feature_detailed_variance_L8_array = zeros(1,total_test_samples);
    feature_detailed_variance_L9_array = zeros(1,total_test_samples);
    feature_AR1_array                  = zeros(1,total_test_samples);
    feature_AR2_array                  = zeros(1,total_test_samples);
    feature_AR_variance                = zeros(1,total_test_samples);

    feature_median_array               = zeros(1,total_test_samples);
    feature_mode_array                 = zeros(1,total_test_samples);
    feature_skewness_array             = zeros(1,total_test_samples);
    feature_kurtosis_array             = zeros(1,total_test_samples);
    feature_min_array                  = zeros(1,total_test_samples);
    feature_max_array                  = zeros(1,total_test_samples);
    feature_mean_crossing_array        = zeros(1,total_test_samples);
    feature_spectral_centroid_array    = zeros(1,total_test_samples);
    feature_Rt_array                   = zeros(1,total_test_samples);
    feature_derivative_max_array       = zeros(1,total_test_samples);
    feature_outlier_ratio_array        = zeros(1,total_test_samples);

for entry_counter = 1:total_test_samples
    freq = freq_peaks_test_MEDIAN(entry_counter,:);
    extract_Features %% call to extract features from 'freq' %%
        feature_mean_array(entry_counter)                 = feature_mean;
        feature_variance_array(entry_counter)             = feature_variance;
        feature_range_array(entry_counter)                = feature_range;
        feature_detailed_variance_L1_array(entry_counter) = feature_detailed_variance_L1;
        feature_detailed_variance_L2_array(entry_counter) = feature_detailed_variance_L2;
        feature_detailed_variance_L3_array(entry_counter) = feature_detailed_variance_L3;
        feature_detailed_variance_L4_array(entry_counter) = feature_detailed_variance_L4;
        feature_detailed_variance_L5_array(entry_counter) = feature_detailed_variance_L5;
        feature_detailed_variance_L6_array(entry_counter) = feature_detailed_variance_L6;
        feature_detailed_variance_L7_array(entry_counter) = feature_detailed_variance_L7;
        feature_detailed_variance_L8_array(entry_counter) = feature_detailed_variance_L8;
        feature_detailed_variance_L9_array(entry_counter) = feature_detailed_variance_L9;
        feature_approx_variance_array(entry_counter)      = feature_approx_variance;
        feature_AR1_array(entry_counter)                  = feature_AR1;
        feature_AR2_array(entry_counter)                  = feature_AR2;
        feature_AR_variance(entry_counter)                = feature_AR_variance;

        feature_median_array(entry_counter)               = feature_median;
        feature_mode_array(entry_counter)                 = feature_mode;
        feature_skewness_array(entry_counter)             = feature_skewness;
        feature_kurtosis_array(entry_counter)             = feature_kurtosis;
        feature_min_array(entry_counter)                  = feature_min;
        feature_max_array(entry_counter)                  = feature_max;
        feature_mean_crossing_array(entry_counter)        = feature_mean_crossing;
        feature_spectral_centroid_array(entry_counter)    = feature_spectral_centroid;
        feature_Rt_array(entry_counter)                   = feature_Rt;
        feature_derivative_max_array(entry_counter)       = feature_derivative_max;
        feature_outlier_ratio_array(entry_counter)        = feature_outlier_ratio;

end
Test_data_MEDIAN = zeros(total_test_samples, total_features);

Test_data_MEDIAN(:,1)  =  feature_mean_array;
Test_data_MEDIAN(:,2)  =  feature_variance_array;
Test_data_MEDIAN(:,3)  =  feature_range_array;
Test_data_MEDIAN(:,4)  =  feature_approx_variance_array;
Test_data_MEDIAN(:,5)  =  feature_detailed_variance_L1_array;
Test_data_MEDIAN(:,6)  =  feature_detailed_variance_L2_array;
Test_data_MEDIAN(:,7)  =  feature_detailed_variance_L3_array;
Test_data_MEDIAN(:,8)  =  feature_detailed_variance_L4_array;
Test_data_MEDIAN(:,9)  =  feature_detailed_variance_L5_array;
Test_data_MEDIAN(:,10) =  feature_detailed_variance_L6_array;
Test_data_MEDIAN(:,11) =  feature_detailed_variance_L7_array;
Test_data_MEDIAN(:,12) =  feature_detailed_variance_L8_array;
Test_data_MEDIAN(:,13) =  feature_detailed_variance_L9_array;
Test_data_MEDIAN(:,14) =  feature_AR1_array;
Test_data_MEDIAN(:,15) =  feature_AR2_array;
Test_data_MEDIAN(:,16) =  feature_AR_variance;

Test_data_MEDIAN(:,17) =  feature_median_array;
Test_data_MEDIAN(:,18) =  feature_mode_array;
Test_data_MEDIAN(:,19) =  feature_skewness_array;
Test_data_MEDIAN(:,20) =  feature_kurtosis_array;
Test_data_MEDIAN(:,21) =  feature_min_array;
Test_data_MEDIAN(:,22) =  feature_max_array;
Test_data_MEDIAN(:,23) =  feature_mean_crossing_array;
Test_data_MEDIAN(:,24) =  feature_spectral_centroid_array;
Test_data_MEDIAN(:,25) =  feature_Rt_array;
Test_data_MEDIAN(:,26) =  feature_derivative_max_array;
Test_data_MEDIAN(:,27) =  feature_outlier_ratio_array;


%~~ Create: Test_data_MEDIAN_normalized ~~%
Test_data_MEDIAN_normalized = zeros(total_test_samples, total_features);
for feature = 1:total_features
    Test_data_MEDIAN_normalized(:,feature) = ...
        ( Test_data_MEDIAN(:,feature) - normalize_mean_param(feature) ) .* ...
        (100 / normalize_max_param(feature)); 
end


% % %% Step: do the multi-class ensemble classification based on power or audio
% % n_guesses_grid = size(Class_Multi_General, 2);
% % Guess_Grid_Ensemble = zeros(total_test_samples, n_guesses_grid);
% % Guess_Grid_Final = zeros(1, total_test_samples);
% % 
% % for sample_n = 1:total_test_samples
% % 
% %     for classi_n = 1:n_guesses_grid
% %         Guess_Grid_Ensemble(sample_n, classi_n) = ...
% %                 predict( Class_Multi_General{classi_n}, Test_data_MEDIAN_normalized(sample_n,:) );
% %     end
% % 
% % end
% % 
% % 
% % 
% % 
% % actual_grid_classes = [1 8 3 6 6 2 7  9 10 4 ...
% %                        1 6 2 4 3 9 10 10 1 5 ...
% %                        8 2 2 1 4 3 7  10 7 2 ...
% %                        4 4 3 8 7 5 1  9  8 9 ...
% %                        5 8 5 3 6 6 10 7  5 9];
% % 
% % for sample_n = 1:50
% %     how_many_grids(sample_n,1) = size( unique( Guess_Grid_Ensemble(sample_n,:) ),2 );
% %     how_many_grids(sample_n,2) = ismember( actual_grid_classes(sample_n), Guess_Grid_Ensemble(sample_n,:) );
% % end
% % disp(['Someone guessed the correct class: ' num2str( sum( how_many_grids(:,2) )) ' times /50']);
% % 
% % 
% % for sample_n = 1:50
% %     for classi_n = 1:20
% %         correct(sample_n,classi_n) = actual_grid_classes(sample_n) == Guess_Grid_Ensemble(sample_n,classi_n) ;
% %     end
% % end
% % 
% % 
% % for classi_n = 1:20
% %     acc(classi_n,counterz) = sum( correct(:,classi_n) ) * 2;
% % end
% % counterz = counterz + 1;
% % 
% % for sample_n = 1:50
% % %     mode_guess(sample_n,1) = mode( [Guess_Grid_Ensemble(sample_n,3) Guess_Grid_Ensemble(sample_n,9) ...
% % %                                 Guess_Grid_Ensemble(sample_n,18)] );
% %     mode_guess(sample_n,1) = mode( Guess_Grid_Ensemble(sample_n,:) );
% % end
% % disp([ 'Mode acc is: ' num2str( sum( mode_guess.' == actual_grid_classes )*2 ) '%' ]);
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
