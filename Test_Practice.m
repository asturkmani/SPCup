% Get Practice data and classify

disp('Started Test_Practice');
clear Class_Multi_General Posterior
<<<<<<< HEAD
test_path_name = 'Practice_dataset/Practice_';

=======

test_path_name = 'Practice_dataset/Practice_';


>>>>>>> b186db04de31d931413d0389ed4af65370d24195
folder = 'Practice_dataset';
fileList = dir(folder);

% # remove all folders
isBadFile = cat(1,fileList.isdir); %# all directories are bad

% # loop to identify hidden files 
for iFile = find(~isBadFile)' %'# loop only non-dirs
%    # on OSX, hidden files start with a dot
   isBadFile(iFile) = strcmp(fileList(iFile).name(1),'.');
   if ~isBadFile(iFile) && ispc
%    # check for hidden Windows files - only works on Windows
   [~,stats] = fileattrib(fullfile(folder,fileList(iFile).name));
   if stats.hidden
      isBadFile(iFile) = true;
   end
   end
end

% # remove bad files
fileList(isBadFile) = [];

<<<<<<< HEAD
=======

>>>>>>> b186db04de31d931413d0389ed4af65370d24195
% Get the number of testing samples:
total_test_samples = size(fileList,1);

% And the number of features is:
total_features = size(Train_data_Audio_normalized, 2);

<<<<<<< HEAD
=======


>>>>>>> b186db04de31d931413d0389ed4af65370d24195
tic
t = templateEnsemble('Bag',30,'Tree','type','classification');
Class_Multi_General{1} = fitcecoc(Train_data_normalized,Train_data_class,'Learners',t,'FitPosterior',1,'Coding', 'binarycomplete');
 
<<<<<<< HEAD
disp('Done training classifiers, time:')
toc









%% Above is given to the GUI, below is done in the GUI

=======
disp('Done training classifiers')
toc
>>>>>>> b186db04de31d931413d0389ed4af65370d24195
test_Type = zeros(50,1);
features_array = zeros(total_test_samples,total_features);
tic
% Step: read ENF with no median, to see if power or audio
parfor sample_n = 1:total_test_samples
    p_name = [test_path_name num2str(sample_n) '.wav'];
    [test_recording, ~] = audioread(p_name);
    [~,~,~,P] = spectrogram(test_recording);
    
    test_Type(sample_n) = max(max(P))<100;
    % if test_Type is audio -> extract ENF with audio params, else with power params
    if test_Type(sample_n) == 0
        test_ENF = extract_ENF(test_recording, apply_median_P, moving_median_width_P, Fs, ...
                                Time_Step_P, Percent_Overlap_P, Padding_Factor, filter_half_size);
<<<<<<< HEAD
    else
        test_ENF = extract_ENF(test_recording, apply_median_A, moving_median_width_A, Fs, ...
                                Time_Step_A, Percent_Overlap_A, Padding_Factor, filter_half_size);
%         figure; plot(test_ENF);
=======
                            
    else
        test_ENF = extract_ENF(test_recording, apply_median_A, moving_median_width_A, Fs, ...
                                Time_Step_A, Percent_Overlap_A, Padding_Factor, filter_half_size);
        figure; plot(test_ENF);
>>>>>>> b186db04de31d931413d0389ed4af65370d24195
    end

    features_array(sample_n, :) = extract_Features( test_ENF );

end
<<<<<<< HEAD
disp('Extract test-ENF time:')
toc


=======
disp('Extract test ENF time')
toc


order_test_data = linspace(1,50,50);

>>>>>>> b186db04de31d931413d0389ed4af65370d24195
actual_grid_classes = [1 8 3 6 6 2 7  9 10 4 ...
                       1 6 2 4 3 9 10 10 1 5 ...
                       8 2 2 1 4 3 7  10 7 2 ... 9 17 18 28 47
                       4 4 3 8 7 5 1  9  8 9 ...
                       5 8 5 3 6 6 10 7  5 9];

% Normalize features
tic
for feature = 1:total_features
features_array(:,feature) = ...
<<<<<<< HEAD
                        ( features_array(:,feature) - normalize_mean_param(feature) ) .* ...
                        (100 / normalize_max_param(feature)); 
end
disp('Normalize features time:');
toc

=======
        ( features_array(:,feature) - normalize_mean_param(feature) ) .* ...
        (100 / normalize_max_param(feature)); 
end
disp('Normalize features time');
toc

% for i=1:total_test_samples %parfor
%     if( sum(features_Audio_order==i)==1)
%         features_array(i,:) = features_array_Audio(features_Audio_order==i,:);
%     else
%         features_array(i,:) = features_array_Power(features_Power_order==i,:);
%     end
% end
>>>>>>> b186db04de31d931413d0389ed4af65370d24195

n_guesses_grid = size(Class_Multi_General, 2);
Guess_Grid_Final = zeros(1, total_test_samples);

tic
<<<<<<< HEAD
classifier = Class_Multi_General{1};
Posterior = zeros(total_test_samples,9);

Guess_Grid_Ensembe = zeros(total_test_samples,1);
parfor sample_n = 1:total_test_samples
    [Guess_Grid_Ensemble(sample_n, 1),~,~,Posterior(sample_n,:)] = predict(classifier, features_array(sample_n,:));
end
disp('Time to classify test samples:')
toc

    
for sample_n = 1:total_test_samples
    [Max_Prob_Value_1(sample_n), Posterior_Max_Grid_1(sample_n)] = max( Posterior(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_1(sample_n)) = -1;
    [Max_Prob_Value_2(sample_n), Posterior_Max_Grid_2(sample_n)] = max( Posterior(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_2(sample_n)) = -2;
    [Max_Prob_Value_3(sample_n), Posterior_Max_Grid_3(sample_n)] = max( Posterior(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_3(sample_n)) = -3;
end


    % Compute final accuracies:
    A = 100*sum(actual_grid_classes(test_Type==1) == Posterior_Max_Grid_1(test_Type==1)) / size(actual_grid_classes(test_Type==1),2);
    P = 100*sum(actual_grid_classes(test_Type==0) == Posterior_Max_Grid_1(test_Type==0)) / size(actual_grid_classes(test_Type==0),2);
    B = 100*sum(actual_grid_classes == Posterior_Max_Grid_1) / size(actual_grid_classes,2);

    disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    disp(['Accuracy of classifier on power: ' num2str(P) '%, on audio: ' num2str(A) '%.']);
    disp(['Accuracy of classifier on both:  ' num2str(B) '%.']);
    disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')


=======

classifier = Class_Multi_General{1};

Posterior = zeros(1,total_test_samples,9);

Guess_Grid_Ensembe = zeros(total_test_samples,1);
parfor sample_n = 1:total_test_samples
    [label,~,~,Posterior(1,sample_n,:)] = predict( classifier, features_array(sample_n,:) );
    Guess_Grid_Ensemble(sample_n, 1) = label;
end
disp('Time to classify samples')
toc


    
    for sample_n = 1:total_test_samples
        for g = 1:9
    %          Posterior_Sum(sample_n,g) = ( Posterior(1,sample_n,g) + Posterior(2,sample_n,g) + Posterior(3,sample_n,g) );
    Posterior_Sum(sample_n,g) = Posterior(k,sample_n,g) ;
        end
        [Max_Prob_Value_1(sample_n), Posterior_Max_Grid_1(sample_n)] = max( Posterior_Sum(sample_n,:) );
        Posterior_Sum(sample_n,Posterior_Max_Grid_1(sample_n)) = -1;
        [Max_Prob_Value_2(sample_n), Posterior_Max_Grid_2(sample_n)] = max( Posterior_Sum(sample_n,:) );
        Posterior_Sum(sample_n,Posterior_Max_Grid_2(sample_n)) = -2;
        [Max_Prob_Value_3(sample_n), Posterior_Max_Grid_3(sample_n)] = max( Posterior_Sum(sample_n,:) );
        Posterior_Sum(sample_n,Posterior_Max_Grid_3(sample_n)) = -3;
    end

%     for i =1:3
%         acc_p(i) =  sum( eval(['Posterior_Max_Grid_' num2str(i)]) == actual_grid_classes )*2 ;
%         disp([ 'Prob Rank ' num2str(i) ' has acc = ' num2str(acc_p(i)) '%']);
%     end
%     disp(['Total being: ' num2str(sum(acc_p)) '%']);
    
    B = 100*sum(actual_grid_classes == Posterior_Max_Grid_1)/size(actual_grid_classes,2);
    disp(['Accuracy of classifier ^ on power:' num2str(P) '%,  on audio:' num2str(A) '%,  and on both:' num2str(B) '%.']);
    disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
>>>>>>> b186db04de31d931413d0389ed4af65370d24195
