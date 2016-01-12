

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
total_features = size(Train_data_normalized, 2);







%% Step: read ENF with no median, to see if power or audio
for sample_n = 1:total_test_samples
    p_name = [test_path_name num2str(sample_n) '.wav'];
    [test_recording, ~] = audioread(p_name);
    freq_peaks_test_NOMEDIAN(sample_n,:) = extract_ENF(test_recording, apply_median, moving_median_width, Fs, ...
                                Time_Step, Percent_Overlap, Padding_Factor, filter_half_size);
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
if( ~apply_median )
    freq_peaks_test_MEDIAN = freq_peaks_test_NOMEDIAN;
end



for entry_counter = 1:total_test_samples
    freq = freq_peaks_test_MEDIAN(entry_counter,:);
    [features_array(entry_counter, :)] = extract_Features( freq );
end

Test_data_MEDIAN = zeros(total_test_samples, total_features);

Test_data_MEDIAN = features_array;



actual_grid_classes = [1 8 3 6 6 2 7  9 10 4 ...
                       1 6 2 4 3 9 10 10 1 5 ...
                       8 2 2 1 4 3 7  10 7 2 ... 9 17 18 28 47
                       4 4 3 8 7 5 1  9  8 9 ...
                       5 8 5 3 6 6 10 7  5 9];




%~~ Create: Test_data_MEDIAN_normalized ~~%
% Test_data_MEDIAN_normalized = zeros(total_test_samples, actual_grid_classes);
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
