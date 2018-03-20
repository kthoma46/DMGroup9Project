dwt_column_list = {'ARX', 'ALY', 'OPR'};
rms_column_list = {"EMG0R", "EMG2R", "EMG3R", "EMG4R"};
std_column_list = {"ARZ", "OPL", "ORR"};
gesture_list = ["about", "and", "can", "cop", "decide", "deaf", "father", "find", "go out", "hearing"];
final_table = table;
pca_input = [];
label_array = [];

for i=1:numel(gesture_list)
    file_name = strcat("Task1Output",'/',gesture_list(i),'.csv');
    cur_table = readtable(file_name,'ReadVariableNames',true);
    gesture_name = array2table(repmat(i,size(cur_table,1),1));
    final_table = [final_table; [gesture_name cur_table(:, 1:48)]];
end

for j=1:numel(dwt_column_list)
    sensor_table = final_table(strcmp(final_table.Sensor,cellstr(dwt_column_list(j))), :);
    dwt_array = [];
    if j==1
        label_table = sensor_table(:, 1);
    end
    for k=1:size(sensor_table, 1)
        row_array = table2array(sensor_table(k, 4:49));  
         
        Y = dwt(row_array,'sym4');
        Y = dwt(Y,'sym4');
        if strcmp(cellstr(dwt_column_list(j)), 'ARX')
            row_y = [Y(6), Y(12)];
        elseif strcmp(cellstr(dwt_column_list(j)), 'ALY')
            row_y = [Y(8), Y(9), Y(10)];
        else
            row_y = [Y(8)];
        end
        dwt_array = [ dwt_array; row_y];
    end
    pca_input = [pca_input dwt_array];
end

for j=1:numel(rms_column_list)
    sensor_table = final_table(strcmp(final_table.Sensor,cellstr(rms_column_list(j))), :);
    rms_array = [];
    for k=1:size(sensor_table, 1)
        row_array = table2array(sensor_table(k, 4:49));   
        rms_val =rms(row_array, 2);
        rms_array = [rms_array; rms_val];
    end
    pca_input = [pca_input rms_array];
end

for j=1:numel(std_column_list)
    sensor_table = final_table(strcmp(final_table.Sensor,cellstr(std_column_list(j))), :);
    std_array = [];
    for k=1:size(sensor_table, 1)
        row_array = table2array(sensor_table(k, 4:49));   
        std_val =std(row_array);
        std_array = [std_array; std_val];
    end
    pca_input = [pca_input std_array];

end
pca_table = array2table(pca_input);
final_pca_table = [label_table pca_table];
writetable(final_pca_table, "Task2Output.csv");


