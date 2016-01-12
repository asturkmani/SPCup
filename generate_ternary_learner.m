function Guess_Grid_Ensemble_Ternary=generate_ternary_learner(t1,t2,t3,m1,m2,m3)
Train_data_normalized_New=cat(t1,t2,t3);

% Create a set of multi-class classifiers for ensemble
Class_Multi_General{1} = fitensemble(Train_data_normalized_New,grid_class_multi,'AdaBoostM2',5,'Discriminant','type','classification');
Class_Multi_General{2} = fitensemble(Train_data_normalized_New,grid_class_multi,'AdaBoostM2',400,'Tree','type','classification');
%
Class_Multi_General{3} = fitensemble(Train_data_normalized_New,grid_class_multi,'LPBoost',95,'Discriminant','type','classification');
Class_Multi_General{4} = fitensemble(Train_data_normalized_New,grid_class_multi,'LPBoost',500,'Tree','type','classification');
%
Class_Multi_General{5} = fitensemble(Train_data_normalized_New,grid_class_multi,'TotalBoost',10,'Discriminant','type','classification');
Class_Multi_General{6} = fitensemble(Train_data_normalized_New,grid_class_multi,'TotalBoost',5,'Tree','type','classification');
%
Class_Multi_General{7} = fitensemble(Train_data_normalized_New,grid_class_multi,'RUSBoost',40,'Discriminant','type','classification');
Class_Multi_General{8} = fitensemble(Train_data_normalized_New,grid_class_multi,'RUSBoost',10,'Tree','type','classification');
%
Class_Multi_General{9} = fitensemble(Train_data_normalized_New,grid_class_multi,'RUSBoost',40,'Discriminant','type','classification');
Class_Multi_General{10} = fitensemble(Train_data_normalized_New,grid_class_multi,'RUSBoost',15,'Tree','type','classification');
%
Class_Multi_General{11} = fitensemble(Train_data_normalized_New,grid_class_multi,'Subspace',50,'Discriminant','type','classification');
Class_Multi_General{12} = fitensemble(Train_data_normalized_New,grid_class_multi,'Subspace',4,'KNN','type','classification');
%
Class_Multi_General{13} = fitensemble(Train_data_normalized_New,grid_class_multi,'Bag',30,'Discriminant','type','classification');
Class_Multi_General{14} = fitensemble(Train_data_normalized_New,grid_class_multi,'Bag',20,'Tree','type','classification');
%
% Class_Multi{15} = fitcnb(Train_data_normalized,grid_class_multi);
Class_Multi_General{15} = fitcecoc(Train_data_normalized_New,grid_class_multi);
Class_Multi_General{16} = fitctree(Train_data_normalized_New,grid_class_multi);
Class_Multi_General{17} = fitcdiscr(Train_data_normalized_New,grid_class_multi);
Class_Multi_General{18} = fitcknn(Train_data_normalized_New,grid_class_multi);
t = templateSVM('KernelFunction','gaussian');
Class_Multi_General{19} = fitcecoc(Train_data_normalized_New,grid_class_multi,'Learners',t,'FitPosterior',1);

% t = templateNaiveBayes();
% Class_Multi{21} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1);
% [label,~,~,Posterior] = resubPredict(Mdl,'Verbose',1);

t = templateEnsemble('Bag',20,'Tree','type','classification');
Class_Multi_General{20} = fitcecoc(Train_data_normalized_New,grid_class_multi,'Learners',t,'FitPosterior',1);

n_guesses_grid = size(Class_Multi_General, 2);
Guess_Grid_Ensemble_Ternary = zeros(total_test_samples, n_guesses_grid);
Guess_Grid_Final = zeros(1, total_test_samples);

for sample_n = 1:total_test_samples

    for classi_n = 1:n_guesses_grid
        Guess_Grid_Ensemble_Ternary(sample_n, classi_n) = ...
                predict( Class_Multi_General{classi_n}, Test_data_MEDIAN_normalized(sample_n,:) );
    end

end


end 