
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




%%%
% t = templateEnsemble('Bag',20,'Tree','type','classification');
% Class_Multi_General{20} = fitcecoc(Train_data_normalized,grid_class_multi,'Learners',t,'FitPosterior',1,'Coding','onevsall');

%%%




n_guesses_grid = size(Class_Multi_General, 2);
Guess_Grid_Ensemble = zeros(total_test_samples, n_guesses_grid);
Guess_Grid_Final = zeros(1, total_test_samples);

for sample_n = 1:total_test_samples

    for classi_n = 1:n_guesses_grid
        Guess_Grid_Ensemble(sample_n, classi_n) = ...
                predict( Class_Multi_General{classi_n}, Test_data_MEDIAN_normalized(sample_n,:) );
    end

end




actual_grid_classes = [1 8 3 6 6 2 7  9 10 4 ...
                       1 6 2 4 3 9 10 10 1 5 ...
                       8 2 2 1 4 3 7  10 7 2 ... 9 17 18 28 47
                       4 4 3 8 7 5 1  9  8 9 ...
                       5 8 5 3 6 6 10 7  5 9];

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
    if( mode_guess2(sample_n,1) < 0 )
        mode_guessBin(sample_n,1) = mode_guess(sample_n,1);
    else
        binary_classifier_needed = BIN_CLASS_GEN.BinaryLearners ...
                                                        { get_binary_index( mode_guess(sample_n,1),mode_guess2(sample_n,1) ) };
        outcome = predict( binary_classifier_needed, Test_data_MEDIAN_normalized(sample_n,:) );
        if( outcome == 1 )
            last_winner_grid = min(mode_guess(sample_n,1), mode_guess2(sample_n,1));
        else
            last_winner_grid = max(mode_guess(sample_n,1), mode_guess2(sample_n,1));
        end
        mode_guessBin(sample_n,1) = last_winner_grid;
    end
end
disp([ 'Mode acc Bin is: ' num2str( sum( mode_guessBin.' == actual_grid_classes )*2 ) '%' ]);




for sample_n = 1:50
    if( mode_guess2(sample_n,1) < 0 )
        mode_guessBin(sample_n,1) = mode_guess(sample_n,1);
    else
        grid1 = mode_guess( sample_n, 1 );
        grid2 = mode_guess2( sample_n, 1 );

        votes_1 = 0;
        for opponent = 1:9
            if opponent ~= grid1
                binary_classifier_needed_1 = BIN_CLASS_GEN.BinaryLearners ...
                                                    { get_binary_index(grid1,opponent) };
                outcome = predict( binary_classifier_needed_1, Test_data_MEDIAN_normalized(sample_n,:) );

                if( outcome == 1 )
                    winner = min( grid1, opponent );
                else %i.e. -1
                    winner = max( grid1, opponent );
                end

                if( winner == grid1 )
                    votes_1 = votes_1 + 1;
                end
            end
        end

        votes_2 = 0;
        for opponent = 1:9
            if opponent ~= grid2
                binary_classifier_needed_2 = BIN_CLASS_GEN.BinaryLearners ...
                                                    { get_binary_index(grid2,opponent) };
                outcome = predict( binary_classifier_needed_2, Test_data_MEDIAN_normalized(sample_n,:) );

                if( outcome == 1 )
                    winner = min( grid2, opponent );
                else %i.e. -1
                    winner = max( grid2, opponent );
                end

                if( winner == grid2 )
                    votes_2 = votes_2 + 1;
                end
            end
        end


        if( votes_2 == votes_1 )
            binary_classifier_needed_1_2 = BIN_CLASS_GEN.BinaryLearners ...
                                                    { get_binary_index(grid1,grid2) };
            outcome = predict( binary_classifier_needed_1_2, Test_data_MEDIAN_normalized(sample_n,:) );
            if( outcome == 1 )
                last_winner_grid = min(grid1, grid2);
            else
                last_winner_grid = max(grid1, grid2);
            end
        elseif( votes_2 > votes_1 )
            last_winner_grid = grid2;
        else
            last_winner_grid = grid1;
        end
        mode_guessVotesBin(sample_n,1) = last_winner_grid;
    end
end
disp([ 'Mode acc VotesBin is: ' num2str( sum( mode_guessVotesBin.' == actual_grid_classes )*2 ) '%' ]);

