%disp(about(1:715, 2: 45));

sensor_array = {'ALX', 'ALY', 'ALZ', 'ARX', 'ARY', 'ARZ', 'EMG0L', 'EMG1L', 'EMG2L', 'EMG3L',...
    'EMG4L', 'EMG5L', 'EMG6L', 'EMG7L', 'EMG0R', 'EMG1R', 'EMG2R', 'EMG3R', 'EMG4R', 'EMG5R',...
    'EMG6R', 'EMG7R', 'GLX', 'GLY', 'GLZ', 'GRX', 'GRY', 'GRZ', 'ORL', 'OPL', 'OYL', 'ORR', 'OPR' ,'OYR'};
avg_matrix = [];
for i=1:numel(sensor_array)
    hold on;
    temp_abt = about(about.Sensor == sensor_array(i), :);
    temp_abt_avg = rms(temp_abt{1:20, 3:45}, 2);

    temp_and = and(and.Sensor == sensor_array(i), :);
    temp_and_avg =   rms(temp_and{1:20, 3:45}, 2);

    temp_can = can(can.Sensor == sensor_array(i), :);
    temp_can_avg = rms(temp_can{1:20, 3:45}, 2);

    temp_cop = cop(cop.Sensor == sensor_array(i), :);
    temp_cop_avg = rms(temp_cop{1:20, 3:45}, 2);

    temp_deaf = deaf(deaf.Sensor == sensor_array(i), :);
    temp_deaf_avg = rms(temp_deaf{1:20, 3:45}, 2);

    temp_decide = decide(decide.Sensor == sensor_array(i), :);
    temp_decide_avg = rms(temp_decide{1:20, 3:45}, 2);
   
    temp_father = father(father.Sensor == sensor_array(i), :);
    temp_father_avg =  rms(temp_father{1:20, 3:45}, 2);
  
    temp_find = find(find.Sensor == sensor_array(i), :);
    temp_find_avg = rms(temp_find{1:20, 3:45}, 2);
    
    temp_goout = goout(goout.Sensor == sensor_array(i), :);
    temp_goout_avg = rms(temp_goout{1:20, 3:45}, 2);
 

    temp_hearing = hearing(hearing.Sensor == sensor_array(i), :);
    temp_hearing_avg = rms(temp_hearing{1:20, 3:45}, 2);
   
    
    box_plot_mat = [temp_abt_avg temp_and_avg temp_can_avg temp_cop_avg temp_deaf_avg ...
                    temp_decide_avg temp_father_avg temp_find_avg temp_goout_avg temp_hearing_avg];
    
    hold off;
 
    disp(box_plot_mat);
    boxplot(box_plot_mat, 'Labels', {'About', 'And', 'Can', 'Cop', 'Deaf', 'Decide', 'Father', 'Find', 'Go Out' , 'Hearing'});
    xlabel('Gesture');
    ylabel('rms');
    title(strcat('rms Box Plot:- ', sensor_array(i)));
    outputFilePath = 'rms';
    if ~exist(outputFilePath, 'dir')
        mkdir(char(outputFilePath));
    end
    filename = char(strcat('rms/', sensor_array(i)));
    disp(filename);
    %saveas(gcf, filename, 'jpg');
end

