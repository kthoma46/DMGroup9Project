sensor_array = {'ALX', 'ALY', 'ALZ', 'ARX', 'ARY', 'ARZ', 'EMG0L', 'EMG1L', 'EMG2L', 'EMG3L',...
    'EMG4L', 'EMG5L', 'EMG6L', 'EMG7L', 'EMG0R', 'EMG1R', 'EMG2R', 'EMG3R', 'EMG4R', 'EMG5R',...
    'EMG6R', 'EMG7R', 'GLX', 'GLY', 'GLZ', 'GRX', 'GRY', 'GRZ', 'ORL', 'OPL', 'OYL', 'ORR', 'OPR' ,'OYR'};
avg_matrix = [];
%about1 = readtable("about.csv");
temp = can(can.Sensor == "GLX", 3:48);
t = temp{:, :};
t(isnan(t)) = 0;
temp{:, :} = t;
N = 2^6;
%for j=1:19
row_array = table2array(temp(:, :));
S=row_array;
Y=fft(S);
V=abs(Y/N);
V1=V(1:N/2);
V1(2:end-1) = 2*V1(2:end-1);
V1rms=V1/sqrt(2);
V1db=20*log10(V1);
f = (0:N/2-1);
V1rmsdb=20*log10(V1rms);
p1db=10*log10(V1rms.*V1rms);
figure(2);
stem(f,p1db);
title('FFT');
xlabel('frequency');
ylabel('dB');
plot(S);
%end
