%% Create Random Forest Tree Classifier:
% BaggedEnsemble = TreeBagger(3000,Train_data_normalized,Train_data_class,'Method','Classification');
% 
% actual_grid_classes = [1 8 3 6 6 2 7  9 10 4 ...
%                        1 6 2 4 3 9 10 10 1 5 ...
%                        8 2 2 1 4 3 7  10 7 2 ... 9 17 18 28 47
%                        4 4 3 8 7 5 1  9  8 9 ...
%                        5 8 5 3 6 6 10 7  5 9];
% 
% label = BaggedEnsemble.predict(Test_data_MEDIAN_normalized);


%% Create Multiclass SVM

t = templateSVM('Standardize',1,'KernelFunction','gaussian');
Mdl = fitcecoc(Train_data_normalized,Train_data_class,'Learners',t,'FitPosterior',1,...
    'ClassNames',{'setosa','versicolor','virginica'},...
    'Verbose',2);
actual_grid_classes = [1 8 3 6 6 2 7  9 10 4 ...
                       1 6 2 4 3 9 10 10 1 5 ...
                       8 2 2 1 4 3 7  10 7 2 ... 9 17 18 28 47
                       4 4 3 8 7 5 1  9  8 9 ...
                       5 8 5 3 6 6 10 7  5 9];

label = predict(SVMMulti,Test_data_MEDIAN_normalized);
                   
for i=1:50
if str2num(label{i}) == actual_grid_classes(i)
s=s+1;
end
end
s=s/50
