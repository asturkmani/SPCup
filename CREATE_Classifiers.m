%% Full code to create and save classifiers
    clearvars;

%% READ training data
    Read_Train_Data;

%% EXTRACT the ENF component frequency across time:
    apply_median = 0;
    moving_median_width = 40;
    Read_ENF_Signal;

%% EXTRACT features from the training data
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
        PA=9;PB=10;PC=11;PD=11;PE=11;PF=8;PG=11;PH=11;PI=11;
        total_entries = PA+PB+PC+PD+PE+PF+PG+PH+PI + 2*(9);
        total_entries = total_entries*2;
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
        feature_mean_array                 = zeros(1,total_entries);
        feature_variance_array             = zeros(1,total_entries);
        feature_range_array                = zeros(1,total_entries);
        feature_approx_variance_array      = zeros(1,total_entries);
        feature_detailed_variance_L1_array = zeros(1,total_entries);
        feature_detailed_variance_L2_array = zeros(1,total_entries);
        feature_detailed_variance_L3_array = zeros(1,total_entries);
        feature_detailed_variance_L4_array = zeros(1,total_entries);
        feature_detailed_variance_L5_array = zeros(1,total_entries);
        feature_detailed_variance_L6_array = zeros(1,total_entries);
        feature_detailed_variance_L7_array = zeros(1,total_entries);
        feature_detailed_variance_L8_array = zeros(1,total_entries);
        feature_detailed_variance_L9_array = zeros(1,total_entries);
        feature_AR1_array                  = zeros(1,total_entries);
        feature_AR2_array                  = zeros(1,total_entries);
        feature_AR_variance                = zeros(1,total_entries);

        feature_median_array               = zeros(1,total_entries);
        feature_mode_array                 = zeros(1,total_entries);
        feature_skewness_array             = zeros(1,total_entries);
        feature_kurtosis_array             = zeros(1,total_entries);
        feature_min_array                  = zeros(1,total_entries);
        feature_max_array                  = zeros(1,total_entries);
        feature_mean_crossing_array        = zeros(1,total_entries);
        feature_spectral_centroid_array    = zeros(1,total_entries);
        feature_Rt_array                   = zeros(1,total_entries);
        feature_derivative_max_array       = zeros(1,total_entries);
        feature_outlier_ratio_array        = zeros(1,total_entries);

        total_features                     = 27;

        grid_class                         = zeros(total_entries, 9);%total_entries, #grids
        grid_class_multi                   = zeros(total_entries,1); %multi class classifier
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
entry_counter = 1;
class_counter = 1;

for grid_name = 'A':'I'
    num_of_power = strcat('P', grid_name);

% Audio
    for i = 1:2
        
        for j = 'A':'B'
        freq = eval(['freq_peaks_' grid_name '_A' num2str(i) j]);
        extract_Features;

        grid_class_multi(entry_counter) = class_counter;

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

        entry_counter = entry_counter + 1;
        end
    end

% Power
    for i = 1:eval(num_of_power)
        for j = 'A':'B'
        freq = eval(['freq_peaks_' grid_name '_P' num2str(i) j]);
        extract_Features;

        grid_class_multi(entry_counter) = class_counter;

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

        entry_counter = entry_counter + 1;
        end
    end

    class_counter = class_counter + 1;
end

disp('Done Feature Extraction');

%% Collect features and normalize
Train_data = zeros(total_entries, total_features);

Train_data(:,1)  =  feature_mean_array;
Train_data(:,2)  =  feature_variance_array;
Train_data(:,3)  =  feature_range_array;
Train_data(:,4)  =  feature_approx_variance_array;
Train_data(:,5)  =  feature_detailed_variance_L1_array;
Train_data(:,6)  =  feature_detailed_variance_L2_array;
Train_data(:,7)  =  feature_detailed_variance_L3_array;
Train_data(:,8)  =  feature_detailed_variance_L4_array;
Train_data(:,9)  =  feature_detailed_variance_L5_array;
Train_data(:,10) =  feature_detailed_variance_L6_array;
Train_data(:,11) =  feature_detailed_variance_L7_array;
Train_data(:,12) =  feature_detailed_variance_L8_array;
Train_data(:,13) =  feature_detailed_variance_L9_array;
Train_data(:,14) =  feature_AR1_array;
Train_data(:,15) =  feature_AR2_array;
Train_data(:,16) =  feature_AR_variance;

Train_data(:,17) =  feature_median_array;
Train_data(:,18) =  feature_mode_array;
Train_data(:,19) =  feature_skewness_array;
Train_data(:,20) =  feature_kurtosis_array;
Train_data(:,21) =  feature_min_array;
Train_data(:,22) =  feature_max_array;
Train_data(:,23) =  feature_mean_crossing_array;
Train_data(:,24) =  feature_spectral_centroid_array;
Train_data(:,25) =  feature_Rt_array;
Train_data(:,26) =  feature_derivative_max_array;
Train_data(:,27) =  feature_outlier_ratio_array;

%%~~ Create: Train_data_normalized ~~%%
[Train_data_normalized, normalize_max_param, normalize_mean_param] = normalize_Features(Train_data, total_features);




%% READ 



CLASSIFY_Sample;
BRUTE_TEST2_prob;










%% TRAIN classifiers

% Get multi-class classifiers for GENERAL:
% Class_Multi_General = CREATE_Classifiers_for_General(Train_data_normalized, grid_class_multi);


% Get multi-class classifiers for GENERAL:
% Class_OVA_General = CREATE_Classifiers_for_General_OVA(Train_data_normalized, grid_class_multi);


% Get Binary classifiers for GENERAL:
% Class_Binary_General = CREATE_Classifiers_for_General_Binary(Train_data_normalized, grid_class_multi);


% Get Ternary classifiers for GENERAL:
% Class_Ternary_General = CREATE_Classifiers_for_General_Ternary(Train_data_normalized, grid_class_multi);



%% SAVE workspace, after clearing all data, leaving classifiers

% clear Audio_Reco* Power_Reco* freq_peaks_*
% clear feature_*
% save('workspace_no_data.mat');


