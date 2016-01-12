%% Full code to create and save classifiers
    clearvars;
    tic
%% For every grid, and for power/audio readwav/readENF/readFeats
% All parameters needed for extract_ENF, run 'help extract_ENF' for more details
apply_median = 0;
moving_median_width = 50;
Fs = 1000;
Time_Step = 0.75;
Percent_Overlap = 0.75;
Padding_Factor = 8;
filter_half_size = 1;
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%

% Some constants:
PA=9;PB=10;PC=11;PD=11;PE=11;PF=8;PG=11;PH=11;PI=11;
grid_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];

train_entries_counter = 1; %index for entry number

for grid_name_idx = 'A':'I'
    % For Audio
    for i = 1:2
        % Get the recording signal
        path_to_recording = ['Grid_' grid_name_idx '\Audio_recordings\Train_Grid_' grid_name_idx '_A' num2str(i) '.wav'];
        [recording_signal, ~] = audioread(path_to_recording);
        % Extract the ENF from the recording
        [result_freq_vs_time1] = extract_ENF(recording_signal(1:size(recording_signal)/2), apply_median, moving_median_width, Fs, ...
                                Time_Step, Percent_Overlap, Padding_Factor, filter_half_size);
        [result_freq_vs_time2] = extract_ENF(recording_signal(size(recording_signal)/2:size(recording_signal)), apply_median, moving_median_width, Fs, ...
                                Time_Step, Percent_Overlap, Padding_Factor, filter_half_size);
        % Extract features from the ENF
        [features_array] = extract_Features( result_freq_vs_time1 );

        %%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
        Train_data(train_entries_counter, :) = features_array;
        Train_data_class(train_entries_counter, 1) = find( ismember(grid_names, grid_name_idx) );
        Train_data_type(train_entries_counter, 1) = 1;
        train_entries_counter = train_entries_counter + 1;
        
        % Extract features from the ENF2
        [features_array] = extract_Features( result_freq_vs_time2 );

        %%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
        Train_data(train_entries_counter, :) = features_array;
        Train_data_class(train_entries_counter, 1) = find( ismember(grid_names, grid_name_idx) );
        Train_data_type(train_entries_counter, 1) = 1;
        train_entries_counter = train_entries_counter + 1;
        %%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
    end

    % For Power
    num_of_power_str = strcat('P', grid_name_idx);
    num_of_power_samples = eval(num_of_power_str);
    for i = 1:num_of_power_samples
        % Get the recording signal
        path_to_recording = ['Grid_' grid_name_idx '\Power_recordings\Train_Grid_' grid_name_idx '_P' num2str(i) '.wav'];
        [recording_signal, ~] = audioread(path_to_recording);
        % Extract the ENF from the recording
        [result_freq_vs_time1] = extract_ENF(recording_signal(1:size(recording_signal)/2), apply_median, moving_median_width, Fs, ...
                                Time_Step, Percent_Overlap, Padding_Factor, filter_half_size);
        [result_freq_vs_time2] = extract_ENF(recording_signal(size(recording_signal)/2:size(recording_signal)), apply_median, moving_median_width, Fs, ...
                                Time_Step, Percent_Overlap, Padding_Factor, filter_half_size);
        % Extract features from the ENF
        [features_array] = extract_Features( result_freq_vs_time1 );

        %%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
        Train_data(train_entries_counter, :) = features_array;
        Train_data_class(train_entries_counter, 1) = find( ismember(grid_names, grid_name_idx) );
        Train_data_type(train_entries_counter, 1) = 1;
        train_entries_counter = train_entries_counter + 1;
        
        % Extract features from the ENF2
        [features_array] = extract_Features( result_freq_vs_time2 );

        %%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
        Train_data(train_entries_counter, :) = features_array;
        Train_data_class(train_entries_counter, 1) = find( ismember(grid_names, grid_name_idx) );
        Train_data_type(train_entries_counter, 1) = 1;
        train_entries_counter = train_entries_counter + 1;
        %%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
    end
end
toc
disp('Done Reading audio, ENF extraction and Train Feature Extraction!');

tic
%%~~ Create: Train_data_normalized ~~%%
[Train_data_normalized, normalize_max_param, normalize_mean_param] = normalize_Features(Train_data, Train_data_class);
toc
disp('Done normalization!');





CLASSIFY_Sample;
BRUTE_TEST2_prob;







%% SAVE workspace, after clearing all data, leaving classifiers

% clear Audio_Reco* Power_Reco* freq_peaks_*
% clear feature_*
% save('workspace_no_data.mat');


