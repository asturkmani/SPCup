% 
% % Create a set of multi-class classifiers for ensemble
% Class_Multi_General{1} = fitensemble(Train_data_normalized,grid_class_multi,'AdaBoostM2',5,'Discriminant','type','classification');
% Class_Multi_General{2} = fitensemble(Train_data_normalized,grid_class_multi,'AdaBoostM2',400,'Tree','type','classification');
% %
% Class_Multi_General{3} = fitensemble(Train_data_normalized,grid_class_multi,'LPBoost',95,'Discriminant','type','classification');
% Class_Multi_General{4} = fitensemble(Train_data_normalized,grid_class_multi,'LPBoost',500,'Tree','type','classification');
% %
% Class_Multi_General{5} = fitensemble(Train_data_normalized,grid_class_multi,'TotalBoost',10,'Discriminant','type','classification');
% Class_Multi_General{6} = fitensemble(Train_data_normalized,grid_class_multi,'TotalBoost',5,'Tree','type','classification');
% %
% Class_Multi_General{7} = fitensemble(Train_data_normalized,grid_class_multi,'RUSBoost',40,'Discriminant','type','classification');
% Class_Multi_General{8} = fitensemble(Train_data_normalized,grid_class_multi,'RUSBoost',10,'Tree','type','classification');
% %
% Class_Multi_General{9} = fitensemble(Train_data_normalized,grid_class_multi,'RUSBoost',40,'Discriminant','type','classification');
% Class_Multi_General{10} = fitensemble(Train_data_normalized,grid_class_multi,'RUSBoost',15,'Tree','type','classification');
% %
% Class_Multi_General{11} = fitensemble(Train_data_normalized,grid_class_multi,'Subspace',50,'Discriminant','type','classification');
% Class_Multi_General{12} = fitensemble(Train_data_normalized,grid_class_multi,'Subspace',4,'KNN','type','classification');
% %
% Class_Multi_General{13} = fitensemble(Train_data_normalized,grid_class_multi,'Bag',30,'Discriminant','type','classification');
% Class_Multi_General{14} = fitensemble(Train_data_normalized,grid_class_multi,'Bag',20,'Tree','type','classification');
% %
% % Class_Multi{15} = fitcnb(Train_data_normalized,grid_class_multi);
% Class_Multi_General{15} = fitcecoc(Train_data_normalized,grid_class_multi);
% Class_Multi_General{16} = fitctree(Train_data_normalized,grid_class_multi);
% Class_Multi_General{17} = fitcdiscr(Train_data_normalized,grid_class_multi);
% Class_Multi_General{18} = fitcknn(Train_data_normalized,grid_class_multi);
% 
% t = templateSVM('KernelFunction','gaussian');
% Class_Multi_General{19} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1);
% 
% % t = templateNaiveBayes();
% % Class_Multi{21} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1);
% % [label,~,~,Posterior] = resubPredict(Mdl,'Verbose',1);
clear Class_Multi_General Posterior

% t = templateEnsemble('Bag',10,'Tree','type','classification');
% Class_Multi_General{1} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1,'Coding', 'allpairs');

% t = templateEnsemble('Bag',20,'Tree','type','classification');
% Class_Multi_General{2} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1,'Coding', 'allpairs');

% t = templateEnsemble('Bag',30,'Tree','type','classification');
% Class_Multi_General{3} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1,'Coding', 'allpairs');

t = templateEnsemble('Bag',300,'Tree','type','classification');
Class_Multi_General{1} = fitcecoc(Train_data_normalized,Train_data_class,'Learners',t,'FitPosterior',1,'Coding', 'binarycomplete');


% t = templateSVM('Standardize',1,'KernelFunction','gaussian');
% Class_Multi_General{1} = fitcecoc(Train_data_normalized,Train_data_class,'Learners',t,'FitPosterior',1);


% t = templateEnsemble('Bag',50,'Discriminant','type','classification');
% Class_Multi_General{3} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1,'Coding', 'binarycomplete');


disp('done training')












n_guesses_grid = size(Class_Multi_General, 2);
Guess_Grid_Ensemble = zeros(total_test_samples, n_guesses_grid);
Guess_Grid_Final = zeros(1, total_test_samples);

parfor sample_n = 1:total_test_samples

    for classi_n = 1:n_guesses_grid
            [label,~,~,Posterior(classi_n,sample_n,:)] = predict( Class_Multi_General{classi_n}, Test_data_MEDIAN_normalized(sample_n,:) );
            Guess_Grid_Ensemble(sample_n, classi_n) = label;
    end
sample_n;
end

actual_grid_classes = [1 8 3 6 6 2 7  9 10 4 ...
                       1 6 2 4 3 9 10 10 1 5 ...
                       8 2 2 1 4 3 7  10 7 2 ... 9 17 18 28 47
                       4 4 3 8 7 5 1  9  8 9 ...
                       5 8 5 3 6 6 10 7  5 9];

for sample_n = 1:total_test_samples
    parfor g = 1:9
%          Posterior_Sum(sample_n,g) = ( Posterior(1,sample_n,g) + Posterior(2,sample_n,g) )/2;
Posterior_Sum(sample_n,g) = Posterior(1,sample_n,g) ;
    end
    [Max_Prob_Value_1(sample_n), Posterior_Max_Grid_1(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_1(sample_n)) = -1;
    [Max_Prob_Value_2(sample_n), Posterior_Max_Grid_2(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_2(sample_n)) = -2;
    [Max_Prob_Value_3(sample_n), Posterior_Max_Grid_3(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_3(sample_n)) = -3;
    [Max_Prob_Value_4(sample_n), Posterior_Max_Grid_4(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_4(sample_n)) = -4;
    [Max_Prob_Value_5(sample_n), Posterior_Max_Grid_5(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_5(sample_n)) = -5;
    [Max_Prob_Value_6(sample_n), Posterior_Max_Grid_6(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_6(sample_n)) = -6;
    [Max_Prob_Value_7(sample_n), Posterior_Max_Grid_7(sample_n)] = max( Posterior_Sum(sample_n,:) );
    Posterior_Sum(sample_n,Posterior_Max_Grid_7(sample_n)) = -7;
    [Max_Prob_Value_8(sample_n), Posterior_Max_Grid_8(sample_n)] = max( Posterior_Sum(sample_n,:) );
end

for i =1:4
    acc_p(i) =  sum( eval(['Posterior_Max_Grid_' num2str(i)]) == actual_grid_classes )*2 ;
    disp([ 'Prob Rank ' num2str(i) ' has acc = ' num2str(acc_p(i)) '%']);
end
disp(['Total being: ' num2str(sum(acc_p)) '%']);
% 
% max_prob_value_diff = (Max_Prob_Value_1 - Max_Prob_Value_2).';
% 
% 
% toc
% 
% for sample_n = 1:50
%     how_many_grids(sample_n,1) = size( unique( Guess_Grid_Ensemble(sample_n,:) ),2 );
%     how_many_grids(sample_n,2) = ismember( actual_grid_classes(sample_n), Guess_Grid_Ensemble(sample_n,:) );
% end
% disp(['Someone guessed the correct class: ' num2str( sum( how_many_grids(:,2) )) ' times /50']);
% 
% 
% for sample_n = 1:50
%     for classi_n = 1:n_guesses_grid
%         correct(sample_n,classi_n) = actual_grid_classes(sample_n) == Guess_Grid_Ensemble(sample_n,classi_n) ;
%     end
%     how_many_grids(sample_n,3) = sum( correct(sample_n,:) ) *100/20;
% end
% 
% 
% for classi_n = 1:n_guesses_grid
%    acc(classi_n,counterz) = sum( correct(:,classi_n) ) * 2;
% end
% counterz = counterz + 1;
% 
% for sample_n = 1:50
% %     mode_guess(sample_n,1) = mode( [Guess_Grid_Ensemble(sample_n,3) Guess_Grid_Ensemble(sample_n,9) ...
% %                                 Guess_Grid_Ensemble(sample_n,18)] );
%     mode_guess(sample_n,1) = mode( Guess_Grid_Ensemble(sample_n,:) );
% end
% disp([ 'Mode acc is: ' num2str( sum( mode_guess.' == actual_grid_classes )*2 ) '%' ]);
% 
