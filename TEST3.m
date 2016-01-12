


%% Divide train data, by grouping according to grid
start_point = 1;
end_point = PA+2;
Train_data_normalize_grid_1 = Train_data_normalized(start_point:end_point, :);
start_point = end_point + 1;
end_point = end_point + PB+2;
Train_data_normalize_grid_2(:,:) = Train_data_normalized(start_point:end_point, :);
start_point = end_point + 1;
end_point = end_point + PC+2;
Train_data_normalize_grid_3(:,:) = Train_data_normalized(start_point:end_point, :);
start_point = end_point + 1;
end_point = end_point + PD+2;
Train_data_normalize_grid_4(:,:) = Train_data_normalized(start_point:end_point, :);
start_point = end_point + 1;
end_point = end_point + PE+2;
Train_data_normalize_grid_5(:,:) = Train_data_normalized(start_point:end_point, :);
start_point = end_point + 1;
end_point = end_point + PF+2;
Train_data_normalize_grid_6(:,:) = Train_data_normalized(start_point:end_point, :);
start_point = end_point + 1;
end_point = end_point + PG+2;
Train_data_normalize_grid_7(:,:) = Train_data_normalized(start_point:end_point, :);
start_point = end_point + 1;
end_point = end_point + PH+2;
Train_data_normalize_grid_8(:,:) = Train_data_normalized(start_point:end_point, :);
start_point = end_point + 1;
end_point = end_point + PI+2;
Train_data_normalize_grid_9(:,:) = Train_data_normalized(start_point:end_point, :);

actual_grid_classes = [1 8 3 6 6 2 7  9 10 4 ...
                       1 6 2 4 3 9 10 10 1 5 ...
                       8 2 2 1 4 3 7  10 7 2 ... 9 17 18 28 47
                       4 4 3 8 7 5 1  9  8 9 ...
                       5 8 5 3 6 6 10 7  5 9];

[ ordered_test,count_grids ] = get_practice( actual_grid_classes,Test_data_MEDIAN_normalized );

%% create ternaries
% Create a set of multi-class classifiers for ensemble
Class_Multi_General{1} = fitensemble(Train_data_normalized,grid_class_multi,'AdaBoostM2',5,'Discriminant','type','classification');
Class_Multi_General{2} = fitensemble(Train_data_normalized,grid_class_multi,'AdaBoostM2',400,'Tree','type','classification');
%
Class_Multi_General{3} = fitensemble(Train_data_normalized,grid_class_multi,'LPBoost',95,'Discriminant','type','classification');
Class_Multi_General{4} = fitensemble(Train_data_normalized,grid_class_multi,'LPBoost',500,'Tree','type','classification');
%
Class_Multi_General{5} = fitensemble(Train_data_normalized,grid_class_multi,'TotalBoost',10,'Discriminant','type','classification');
Class_Multi_General{6} = fitensemble(Train_data_normalized,grid_class_multi,'TotalBoost',5,'Tree','type','classification');
%
Class_Multi_General{7} = fitensemble(Train_data_normalized,grid_class_multi,'RUSBoost',40,'Discriminant','type','classification');
Class_Multi_General{8} = fitensemble(Train_data_normalized,grid_class_multi,'RUSBoost',10,'Tree','type','classification');
%
Class_Multi_General{9} = fitensemble(Train_data_normalized,grid_class_multi,'RUSBoost',40,'Discriminant','type','classification');
Class_Multi_General{10} = fitensemble(Train_data_normalized,grid_class_multi,'RUSBoost',15,'Tree','type','classification');
%
Class_Multi_General{11} = fitensemble(Train_data_normalized,grid_class_multi,'Subspace',50,'Discriminant','type','classification');
Class_Multi_General{12} = fitensemble(Train_data_normalized,grid_class_multi,'Subspace',4,'KNN','type','classification');
%
Class_Multi_General{13} = fitensemble(Train_data_normalized,grid_class_multi,'Bag',30,'Discriminant','type','classification');
Class_Multi_General{14} = fitensemble(Train_data_normalized,grid_class_multi,'Bag',20,'Tree','type','classification');
%
% Class_Multi{15} = fitcnb(Train_data_normalized,grid_class_multi);
Class_Multi_General{15} = fitcecoc(Train_data_normalized,grid_class_multi);
Class_Multi_General{16} = fitctree(Train_data_normalized,grid_class_multi);
Class_Multi_General{17} = fitcdiscr(Train_data_normalized,grid_class_multi);
Class_Multi_General{18} = fitcknn(Train_data_normalized,grid_class_multi);

t = templateSVM('KernelFunction','gaussian');
Class_Multi_General{19} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1);

% t = templateNaiveBayes();
% Class_Multi{21} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1);
% [label,~,~,Posterior] = resubPredict(Mdl,'Verbose',1);

t = templateEnsemble('Bag',20,'Tree','type','classification');
Class_Multi_General{20} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1);


n_guesses_grid = size(Class_Multi_General, 2);
Guess_Grid_Ensemble = zeros(total_test_samples, n_guesses_grid);
Guess_Grid_Final = zeros(1, total_test_samples);

for sample_n = 1:total_test_samples

    for classi_n = 1:n_guesses_grid
        Guess_Grid_Ensemble(sample_n, classi_n) = ...
                predict( Class_Multi_General{classi_n}, Test_data_MEDIAN_normalized(sample_n,:) );
    end

end

for sample_n = 1:50
    how_many_grids(sample_n,1) = size( unique( Guess_Grid_Ensemble(sample_n,:) ),2 );
    how_many_grids(sample_n,2) = ismember( actual_grid_classes(sample_n), Guess_Grid_Ensemble(sample_n,:) );
end
disp(['Someone guessed the correct class: ' num2str( sum( how_many_grids(:,2) )) ' times /50']);


for sample_n = 1:50
    for classi_n = 1:20
        correct(sample_n,classi_n) = actual_grid_classes(sample_n) == Guess_Grid_Ensemble(sample_n,classi_n) ;
    end
    how_many_grids(sample_n,3) = sum( correct(sample_n,:) ) *100/20;
end


for classi_n = 1:20
    
    acc(classi_n,counterz) = sum( correct(:,classi_n) ) * 2;
     
end
counterz = counterz + 1;

for sample_n = 1:50
%     mode_guess(sample_n,1) = mode( [Guess_Grid_Ensemble(sample_n,3) Guess_Grid_Ensemble(sample_n,9) ...
%                                 Guess_Grid_Ensemble(sample_n,18)] );
    mode_guess(sample_n,1) = mode( Guess_Grid_Ensemble(sample_n,:) );
    for classi_n = 1:20
        if( Guess_Grid_Ensemble(sample_n,classi_n) == mode_guess(sample_n,1) )
            Guess_Grid_Ensemble(sample_n,classi_n) = -1*rand;
        end            
    end
    mode_guess2(sample_n,1) = mode( Guess_Grid_Ensemble(sample_n,:) );
    for classi_n = 1:20
        if( Guess_Grid_Ensemble(sample_n,classi_n) == mode_guess2(sample_n,1) )
            Guess_Grid_Ensemble(sample_n,classi_n) = -1*rand;
        end            
    end
   
end
disp([ 'Mode acc 1 is: ' num2str( sum( mode_guess.' == actual_grid_classes )*2 ) '%' ]);
disp([ 'Mode acc 2 is: ' num2str( sum( mode_guess2.' == actual_grid_classes )*2 ) '%' ]);

for classi_n = 1:20
    if( Guess_Grid_Ensemble(sample_n,classi_n) == mode_guess2(sample_n,1) )
        Guess_Grid_Ensemble(sample_n,classi_n) = -2*rand;
    end            
end
mode_guess3(sample_n,1) = mode( Guess_Grid_Ensemble(sample_n,:) );
disp([ 'Mode acc 3 is: ' num2str( sum( mode_guess3.' == actual_grid_classes )*2 ) '%' ]);

for sample_n = 1:50

    Final_Guess_Grid_Ensemble_Ternary=generate_ternary_learner(strcat('Train_data_normalize_grid_',num2str(mode_guess(sample_n,1))),strcat('Train_data_normalize_grid_',num2str(mode_guess2(sample_n,1))),strcat('Train_data_normalize_grid_',num2str(mode_guess3(sample_n,1))),mode_guess(sample_n,1),mode_guess2(sample_n,1),mode_guess3(sample_n,1));
end 