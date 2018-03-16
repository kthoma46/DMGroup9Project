%disp(about(1:715, 2: 45));

sensor_array = {'ALX', 'ALY', 'ALZ', 'ARX', 'ARY', 'ARZ', 'EMG0L', 'EMG1L', 'EMG2L', 'EMG3L',...
    'EMG4L', 'EMG5L', 'EMG6L', 'EMG7L', 'EMG0R', 'EMG1R', 'EMG2R', 'EMG3R', 'EMG4R', 'EMG5R',...
    'EMG6R', 'EMG7R', 'GLX', 'GLY', 'GLZ', 'GRX', 'GRY', 'GRZ', 'ORL', 'OPL', 'OYL', 'ORR', 'OPR' ,'OYR'};
avg_matrix = [];
temp = about(about.Sensor == "ALX", 3:45);
t = temp{:, :};
t(isnan(t)) = 0;
temp{:, :} = t;
hold on;
for j=1:19
    plot(table2array(temp(j, :)));
end
xlabel('Value');
ylabel('Time');
title(strcat('Line graph '));
saveas(gcf,"ALX grpah");
hold off;
