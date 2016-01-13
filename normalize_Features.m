function [Train_data_normalized, normalize_max_param, normalize_mean_param] = normalize_Features(Train_data, Train_data_class)
%% Input a train data matrix, with corresponding grid classes
% Outputs the normalized features across grids
% And the normalize_max_param and normalize_mean_param

%% Get normalization parameters:
total_entries = size(Train_data, 1);
total_features = size(Train_data, 2);


normalize_max_param  = zeros(1,total_features);
normalize_mean_param = zeros(1,total_features);

parfor feature = 1:total_features

    mean_each_grid = zeros(1,9); %the mean in each grid for this feature
    last_grid_entry = 0;

    for grid_ind = 1:9

        first_grid_entry = last_grid_entry + 1;             %pointer to the first entry in each grid
        if (grid_ind == 9)
            last_grid_entry = total_entries;
        else
            last_grid_entry = first_grid_entry;
            while( Train_data_class(last_grid_entry) == grid_ind )
                last_grid_entry = last_grid_entry + 1;
            end
            last_grid_entry = last_grid_entry - 1;
        end

        for entry = first_grid_entry:last_grid_entry
            mean_each_grid(grid_ind) = mean_each_grid(grid_ind) + Train_data(entry,feature);
        end
        mean_each_grid(grid_ind) = mean_each_grid(grid_ind) / (last_grid_entry - first_grid_entry + 1);
    end

    normalize_mean_param(feature) = mean( mean_each_grid );

end

% Normalize:
Train_data_normalized = zeros(total_entries,total_features);

for feature = 1:total_features

    sub_mean_train_temp = (Train_data(:,feature) - normalize_mean_param(feature) );

    normalize_max_param(feature) = max( abs( sub_mean_train_temp ) );

    scale_temp = 100 / normalize_max_param(feature);

    Train_data_normalized(:,feature) = sub_mean_train_temp .* scale_temp;

end

