function Class_Multi_General = CREATE_Classifiers_for_General(Train_data_normalized_General, grid_class_multi_General)


% Create a set of multi-class classifiers for ensemble
Class_Multi_General{1} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'AdaBoostM2',5,'Discriminant','type','classification');
Class_Multi_General{2} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'AdaBoostM2',400,'Tree','type','classification');
%
Class_Multi_General{3} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'LPBoost',95,'Discriminant','type','classification');
Class_Multi_General{4} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'LPBoost',20,'Tree','type','classification');
%
Class_Multi_General{5} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'TotalBoost',10,'Discriminant','type','classification');
Class_Multi_General{6} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'TotalBoost',5,'Tree','type','classification');
%
Class_Multi_General{7} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'RUSBoost',40,'Discriminant','type','classification');
Class_Multi_General{8} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'RUSBoost',20,'Discriminant','type','classification');
%
Class_Multi_General{9} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'RUSBoost',10,'Discriminant','type','classification');
Class_Multi_General{10} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'Bag',50,'Discriminant','type','classification');
%
Class_Multi_General{11} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'Subspace',50,'Discriminant','type','classification');
Class_Multi_General{12} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'RUSBoost',30,'Discriminant','type','classification');
%
Class_Multi_General{13} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'Bag',30,'Discriminant','type','classification');
Class_Multi_General{14} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'Bag',20,'Tree','type','classification');
%
Class_Multi_General{15} = fitcecoc(Train_data_normalized_General,grid_class_multi_General);
Class_Multi_General{16} = fitctree(Train_data_normalized_General,grid_class_multi_General);
Class_Multi_General{17} = fitcdiscr(Train_data_normalized_General,grid_class_multi_General);
Class_Multi_General{18} = fitcknn(Train_data_normalized_General,grid_class_multi_General);

Class_Multi_General{19} = fitensemble(Train_data_normalized_General,grid_class_multi_General,'RUSBoost',60,'Discriminant','type','classification');


% t = templateSVM('KernelFunction','gaussian');
% Class_Multi_General{19} = fitcecoc(Train_data_normalized_General,grid_class_multi_General,'Learners',t,'FitPosterior',1);

% t = templateNaiveBayes();
% Class_Multi{21} = fitcecoc(Train_data_normalized_General,grid_class_multi_General,'Learners',t,'FitPosterior',1);
% [label,~,~,Posterior] = resubPredict(Mdl,'Verbose',1);

t = templateEnsemble('Bag',20,'Discriminant','type','classification');
Class_Multi_General{20} = fitcecoc(Train_data_normalized_General,grid_class_multi_General,'Learners',t,'FitPosterior',1);



