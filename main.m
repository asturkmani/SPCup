%% Full code to create and save classifiers
    clearvars;
    tic
%% For every grid, and for power/audio readwav/readENF/readFeats
% All parameters needed for extract_ENF, run 'help extract_ENF' for more details
apply_median = 0;
moving_median_width = 50;
Fs = 1000;
Time_Step = 0.5;
Percent_Overlap = 0.85;
Padding_Factor = 8;
filter_half_size = 1;
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%

% Some constants:
PA=9;PB=10;PC=11;PD=11;PE=11;PF=8;PG=11;PH=11;PI=11;
grid_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];
scaling_f = 1;
features_size = 27;

Training_entries = (PA + PB + PC + PD + PE + PF + PG + PH + PI)*scaling_f;
Train_data = [];
Train_data_class = [];
Train_data_type = [];

train_entries_counter = 1; %index for entry number

for grid_name_idx = 'A':'I'
    % For Audio
    
    grid_class_number = find( ismember(grid_names, grid_name_idx) );
    recording_signal = [];
    parfor i = 1:2
        % Get the recording signal
        path_to_recording = ['Grid_' grid_name_idx '/Audio_recordings/Train_Grid_' grid_name_idx '_A' num2str(i) '.wav'];
        [recording_signal, ~] = audioread(path_to_recording);
        % Extract the ENF from the recording
        sizeT = size(recording_signal,1);
        temp = 1;
        while(temp<sizeT)
            if(sizeT-temp>=360000)
                
             [result_freq_vs_time] = extract_ENF(recording_signal(temp:(temp-1+360000)), apply_median, moving_median_width, Fs, ...
                                 Time_Step, Percent_Overlap, Padding_Factor, filter_half_size);
            
            else
             [result_freq_vs_time] = extract_ENF(recording_signal((sizeT-360000):sizeT), apply_median, moving_median_width, Fs, ...
                                 Time_Step, Percent_Overlap, Padding_Factor, filter_half_size);
            
            
            end
            
                     % Extract features from the ENF
            [features_array] = extract_Features( result_freq_vs_time );
        
        %%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
        Train_data = [Train_data; features_array];
        Train_data_class = [Train_data_class; grid_class_number];
        Train_data_type = [Train_data_type; 1];
        train_entries_counter = train_entries_counter + 1;
        temp = temp + 360000; 
        end
    end
    % For Power
    num_of_power_str = strcat('P', grid_name_idx);
    num_of_power_samples = eval(num_of_power_str);
    parfor i = 1:num_of_power_samples
        % Get the recording signal
        path_to_recording = ['Grid_' grid_name_idx '/Power_recordings/Train_Grid_' grid_name_idx '_P' num2str(i) '.wav'];
        [recording_signal, ~] = audioread(path_to_recording);
        % Extract the ENF from the recording
        sizeT = size(recording_signal,1);
        temp = 1;
        while(temp<sizeT)      
            if(sizeT-temp>=720000)
                
             [result_freq_vs_time] = extract_ENF(recording_signal(temp:(temp-1+720000)), apply_median, moving_median_width, Fs, ...
                                 Time_Step, Percent_Overlap, Padding_Factor, filter_half_size);
            else
             [result_freq_vs_time] = extract_ENF(recording_signal((sizeT-720000):sizeT), apply_median, moving_median_width, Fs, ...
                                 Time_Step, Percent_Overlap, Padding_Factor, filter_half_size);
            end
            
                     % Extract features from the ENF
            [features_array] = extract_Features( result_freq_vs_time );
        
        %%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
        Train_data = [Train_data; features_array];
        Train_data_class = [Train_data_class; grid_class_number];
        Train_data_type = [Train_data_type; 1];
        train_entries_counter = train_entries_counter + 1;
                    temp = temp + 720000; 
        end

    end
end
disp('Done Reading audio, ENF extraction and Train Feature Extraction!');
%%~~ Create: Train_data_normalized ~~%%
Train_data_Audio = Train_data(Train_data_type==1,:);
Train_data_Audio_Class = Train_data_class(Train_data_type==1);

Train_data_Power = Train_data(Train_data_type==0,:);
Train_data_Power_Class = Train_data_class(Train_data_type==0);

[Train_data_Audio_normalized, normalize_max_param_Audio, normalize_mean_param_Audio] = normalize_Features(Train_data_Audio, Train_data_Audio_Class);
[Train_data_Power_normalized, normalize_max_param_Power, normalize_mean_param_Power] = normalize_Features(Train_data_Power, Train_data_Power_Class);
[Train_data_normalized, normalize_max_param, normalize_mean_param] = normalize_Features(Train_data, Train_data_class);

disp('Done normalization!');



Test_Practice;
% 
% CLASSIFY_Sample;
% BRUTE_TEST2_prob;

toc
beep

% load handel
sound(1,Fs)




%% SAVE workspace, after clearing all data, leaving classifiers

% clear Audio_Reco* Power_Reco* freq_peaks_*
% clear feature_*
% save('workspace_no_data.mat');


