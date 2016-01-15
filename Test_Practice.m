% Get Practice data and classify

disp('Started Test_Practice');
clear Class_Multi_General Posterior

test_path_name = 'Practice_dataset/Practice_';


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


% Get the number of testing samples:
total_test_samples = size(fileList,1);

% And the number of features is:
total_features = size(Train_data_Audio_normalized, 2);



tic
t = templateEnsemble('Bag',30,'Tree','type','classification');
Class_Multi_General{1} = fitcecoc(Train_data_Power_normalized,Train_data_Power_Class,'Learners',t,'FitPosterior',1,'Coding', 'binarycomplete');

t = templateEnsemble('Bag',30,'Tree','type','classification');
Class_Multi_General{1} = fitcecoc(Train_data_Audio_normalized,Train_data_Audio_Class,'Learners',t,'FitPosterior',1,'Coding', 'binarycomplete');

t = templateEnsemble('Bag',30,'Tree','type','classification');
Class_Multi_General{2} = fitcecoc(Train_data_normalized,Train_data_class,'Learners',t,'FitPosterior',1,'Coding', 'binarycomplete');
 
disp('Done training classifiers')
toc
test_Type = zeros(50,1);
test_Audio_ENF = zeros(22,total_features);
test_Power_ENF = zeros(28,total_features);
features_array = zeros(total_test_samples,size(features_array,2));
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
                            
    else
        test_ENF = extract_ENF(test_recording, apply_median_A, moving_median_width_A, Fs, ...
                                Time_Step_A, Percent_Overlap_A, Padding_Factor, filter_half_size);
        figure; plot(test_ENF);
    end

    features_array(sample_n, :) = extract_Features( test_ENF );

end
disp('Extract test ENF time')
toc


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

features_array2 = zeros(size(features_array));

% Normalize features
tic
for feature = 1:total_features
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
disp('Normalize features time');
toc

% for i=1:total_test_samples %parfor
%     if( sum(features_Audio_order==i)==1)
%         features_array(i,:) = features_array_Audio(features_Audio_order==i,:);
%     else
%         features_array(i,:) = features_array_Power(features_Power_order==i,:);
%     end
% end

n_guesses_grid = size(Class_Multi_General, 2);
Guess_Grid_Final = zeros(1, total_test_samples);

tic

classifier1 = Class_Multi_General{1};
classifier2 = Class_Multi_General{2};
classifier3 = Class_Multi_General{3};

Posterior1 = zeros(1,total_test_samples,9);
Posterior2 = zeros(1,total_test_samples,9);
Posterior3 = zeros(1,total_test_samples,9);

Guess_Grid_Ensembe1 = zeros(total_test_samples,1);
Guess_Grid_Ensembe2 = zeros(total_test_samples,1);
Guess_Grid_Ensembe3 = zeros(total_test_samples,1);
parfor sample_n = 1:total_test_samples
    [label,~,~,Posterior1(1,sample_n,:)] = predict( classifier1, features_array(sample_n,:) );
    Guess_Grid_Ensemble1(sample_n, 1) = label;

    [label,~,~,Posterior2(1,sample_n,:)] = predict( classifier2, features_array(sample_n,:) );
    Guess_Grid_Ensemble2(sample_n, 1) = label;

    [label,~,~,Posterior3(1,sample_n,:)] = predict( classifier3, features_array2(sample_n,:) );
    Guess_Grid_Ensemble3(sample_n, 1) = label;
end
disp('Time to classify samples')
toc

Posterior = cat(1,Posterior1,Posterior2,Posterior3);
Guess_Grid_Ensemble = [Guess_Grid_Ensembe1, Guess_Grid_Ensembe2, Guess_Grid_Ensembe3];

for k=1:2
    if k==1
        disp('Classifier trained on power data only:');
    elseif k==2
        disp('Classifier trained on audio data only:');
    else
        disp('Classifier trained on both audio and power:');
    end
    
    
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
    
    P = 100*sum(actual_grid_classes(test_Type==0) == Posterior_Max_Grid_1(test_Type==0))/size(actual_grid_classes(test_Type==0),2);
    A = 100*sum(actual_grid_classes(test_Type==1) == Posterior_Max_Grid_1(test_Type==1))/size(actual_grid_classes(test_Type==1),2);
    B = 100*sum(actual_grid_classes == Posterior_Max_Grid_1)/size(actual_grid_classes,2);
    disp(['Accuracy of classifier ^ on power:' num2str(P) '%,  on audio:' num2str(A) '%,  and on both:' num2str(B) '%.']);
    disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
end
