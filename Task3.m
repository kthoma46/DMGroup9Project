X_table = readtable("Task2Output.csv");
X = table2array(X_table);
plot_array = [1,2,3,4,5,6,7,8,9,10,11,12,13];

%PCA
[coeff, score, latent] = pca(X(:,2:end));

%{
Bar_List = categorical({'DWT-ARX[6]' , 'DWT-ARX[12]' , 'DWT-ALY[8]', 'DWT-ALY[9]', 'DWT-ALY[10]', 'DWT-OPR[8]', 'RMS-EMG0R', 'RMS-EMG2R' , 'RMS-EMG3R' , 'RMS-EMG4R' , 'STD-ARZ' , 'STD-OPL' , 'STD-ORR'});

for i = 1:size(coeff,2)
    pc = coeff(:,i);
    bar(Bar_List, pc);
    ylabel('Coefficient Value');
    name = "Eigen Value " + i;
    title(name);
    filename = char(strcat("EigenValues/",name));
    saveas(gcf, filename, 'png');
end
%}

labels = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

principle_components = [score(:,[1,2,3]) X(:, 1)];
gesture_list = ["about", "and", "can", "cop", "decide", "deaf", "father", "find", "go out", "hearing"];


for current_pc=1:3
    pc = [];
    boxPlotMatrix = [];
    for class = 1:10
        pc_per_class = principle_components(principle_components(:,end)==class, [current_pc]);
        %{
        pc_per_class_temp = [pc_per_class; zeros(size(X,1)-size(pc_per_class,1), 1)];
        pc = [pc pc_per_class_temp];
        %}
        histogram(pc_per_class, 25);
        %{
        if class==1
            boxPlotMatrix = pc_per_class(1:10, 1);
        else
            boxPlotMatrix = [boxPlotMatrix pc_per_class(1:10, 1)];
        end
        %}
        title(strcat(strcat(gesture_list(class), '-PrincipleComponent-'), num2str(current_pc)));
        xlabel('Component Value');
        ylabel('Frequency');
        filename = char(strcat('PC/', strcat(strcat(gesture_list(class), '_PrincipleComponent_'), num2str(current_pc))));
        saveas(gcf, filename, 'png');
    end
    %boxplot(boxPlotMatrix);
    %{
    boxplot(pc, 'Labels', {'About', 'And', 'Can', 'Cop', 'Deaf', 'Decide', 'Father', 'Find', 'Go Out' , 'Hearing'});
    xlabel('Gesture');
    ylabel(strcat('Principle Component ', num2str(current_pc)));
    title(strcat('Principle Component ', num2str(current_pc)));
    outputFilePath = 'PC';
    if ~exist(outputFilePath, 'dir')
        mkdir(char(outputFilePath));
    end
    filename = char(strcat('PC/', strcat('PrincipleComponent_', num2str(current_pc))));
    disp(filename);
    saveas(gcf, filename, 'jpg');
    %}
end