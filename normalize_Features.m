function [Train_data_normalized, normalize_max_param, normalize_mean_param] = normalize_Features(Train_data, total_features)

        PA=9;PB=10;PC=11;PD=11;PE=11;PF=8;PG=11;PH=11;PI=11;
        total_entries = PA+PB+PC+PD+PE+PF+PG+PH+PI + 2*(9);
        total_entries = total_entries*2;

% Get normalization parameters:
ind = 1;
for grid_name = 'A':'I'
    map_letters(ind) = grid_name; %Map numbers -> letters
    ind = ind + 1;
end

normalize_max_param  = zeros(1,total_features);
normalize_mean_param = zeros(1,total_features);

for feature = 1:total_features

    mean_each_grid = zeros(1,9); %the mean in each grid for this feature
    last_grid_entry = 0;

    for grid_ind = 1:9

        grid_name = map_letters(grid_ind);
        num_of_power = strcat('P', grid_name);
        entries_in_grid = eval(num_of_power) + 2;

        first_grid_entry = last_grid_entry + 1;             %pointer to the first entry in each grid
        last_grid_entry = last_grid_entry + entries_in_grid;%pointer to the last entry in each grid

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

