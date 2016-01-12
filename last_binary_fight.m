

% REQUIRES SETTING:
% ranking_array:              top prob [1 2 3 4 5 6 7 8 9] grids ranked according to probabilities
%                             top grid [5 3 8 2 1 4 7 9 6]  FOR EACH SAMPLE
%
% last_grid_index_threshold:  6 for example to say disregrad 7 8 & 9
%
% binary classifiers:         one vs one

ranking_array = [ Posterior_Max_Grid_1(:) Posterior_Max_Grid_2(:) Posterior_Max_Grid_3(:) ...
                  Posterior_Max_Grid_4(:) Posterior_Max_Grid_5(:) Posterior_Max_Grid_6(:) ...
                  Posterior_Max_Grid_7(:) Posterior_Max_Grid_8(:) ];
last_grid_index_threshold = 4;




FINAL_WINNER = zeros(total_test_samples,1);


for sample_n = 1:total_test_samples
if sample_n==25
    a=1;
end
    last_winner_grid = ranking_array( sample_n, last_grid_index_threshold );  %the weakest one we start with

    for last_grid_index = last_grid_index_threshold:-1:2  %move along with fights starting with least prob grid

        grid1 = ranking_array( sample_n, last_grid_index - 1 );
        grid2 = last_winner_grid;

        votes_1 = 0;
        for opponent = 1:9
            if opponent ~= grid1
                binary_classifier_needed_1 = Class_Multi_General{1}.BinaryLearners ...
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
                binary_classifier_needed_2 = Class_Multi_General{1}.BinaryLearners ...
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
            binary_classifier_needed_1_2 = Class_Multi_General{1}.BinaryLearners ...
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

        if( last_winner_grid == grid2 )
            disp('-');
            ranking_array( sample_n, last_grid_index ) = grid1;
            ranking_array( sample_n, last_grid_index - 1 ) = grid2;
        end

    end


    FINAL_WINNER(sample_n,1) = last_winner_grid;
    sample_n

end



sum( FINAL_WINNER.' == actual_grid_classes )*2












