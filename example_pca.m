load imports-85;
[coeff, score, latent] = pca(X(:,3:15));

sample = [1,2,3,4,5,6,7,8,9,10];

class_column = datasample(sample, size(X,1));

principle_components = [score(:,[1,2,3]) class_column.'];

for current_pc=1:3
    pc = [];
    for class = 1:10
        pc_per_class = principle_components(principle_components(:,end)==class, [current_pc]);
        pc_per_class_temp = [pc_per_class; zeros(size(X,1)-size(pc_per_class,1), 1)];
        pc = [pc pc_per_class_temp];
    end
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
end