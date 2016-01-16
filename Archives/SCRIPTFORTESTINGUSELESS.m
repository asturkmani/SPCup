
test = 5;

for x=1:9
    if x~=test
predict( Class_Binary_Power{2}.BinaryLearners{ get_binary_index(x,test) } , Test_data_MEDIAN_normalized(49,:) )
    end
end



% a1 b2 c3 d4 e5 f6 g7 h8 i9

actual_grid_classes = [1 8 3 6 6 2 7  9 10 4 ...
                       1 6 2 4 3 9 10 10 1 5 ...
                       8 2 2 1 4 3 7  10 7 2 ...
                       4 4 3 8 7 5 1  9  8 9 ...
                       5 8 5 3 6 6 10 7  5 9];




for sample_n = 1:50
%     inside(sample_n) = ismember( actual_grid_classes(sample_n), Guess_Grid_Ensemble(sample_n,:) );
    how_many_grids(sample_n) = size( unique( Guess_Grid_Ensemble(sample_n,:) ),2 );
end


for sample_n = 1:50
    for classi_n = 1:20
        correct(sample_n,classi_n) = actual_grid_classes(sample_n) == Guess_Grid_Ensemble(sample_n,classi_n) ;
    end
end


for classi_n = 1:20
    acc(classi_n) = sum( correct(:,classi_n) ) * 2;
end

