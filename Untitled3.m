prompt = "Enter the base directory folder = ";
baseDirectory = input(char(prompt), 's');

gestures = ["about", "and", "can", "cop", "deaf", "decide", "father", "go out", "find", "hearing"];
groupFolders = ["DM01", "DM02", "DM04", "DM05", "DM11", "DM12"];
csvData = ["Group Data" "Gesture" "Model" "Precision" "Recall" "F1"];
for i = 1:numel(groupFolders)
    for j = 1:numel(gestures)
       pathOfFile = baseDirectory + "\" + groupFolders(i) + "\" + gestures(j) + ".csv";
       fileContent = readtable(pathOfFile);
       featureMatrix = table2array(fileContent);
       
       [numRows, numColumns] = size(featureMatrix);
       numTrainingRows = int16(0.75 * numRows);
       trainData = featureMatrix(1:numTrainingRows,1:end-1);
       trainLabels = featureMatrix(1:numTrainingRows,end);
       testData = featureMatrix(numTrainingRows + 1:end, 1: end-1);
       actualLabels = featureMatrix(numTrainingRows + 1:end, end);
       
       dt = fitctree(trainData, trainLabels);
       predictedLabels = predict(dt, testData);
       confusionMatrix = confusionmat(actualLabels', predictedLabels');
       TP = confusionMatrix(2,2);
       FP = confusionMatrix(1,2);
       FN = confusionMatrix(2,1);
       precision = TP/(TP+FP);
       recall = TP/(TP+FN);
       F1 = 2 * recall * precision / (precision + recall);
       newCsvData = [groupFolders(i) gestures(j) "Decision Tree" precision recall F1];
       csvData = [csvData; newCsvData];
       
       svm = fitcsvm(trainData, trainLabels, 'KernelFunction', 'polynomial', 'PolynomialOrder', 10);
       predictedLabels = predict(svm, testData);
       confusionMatrix = confusionmat(actualLabels', predictedLabels');
       TP = confusionMatrix(2,2);
       FP = confusionMatrix(1,2);
       FN = confusionMatrix(2,1);
       precision = TP/(TP+FP);
       recall = TP/(TP+FN);
       F1 = 2 * recall * precision / (precision + recall);
       newCsvData = [groupFolders(i) gestures(j) "SVM" precision recall F1];
       csvData = [csvData; newCsvData];
       
       neuralNet = feedforwardnet(15);
       trainedNeuralNet = train(neuralNet, trainData', trainLabels');
       predictedOutputs = trainedNeuralNet(testData');
       predictedLabels = zeros(1, numel(predictedOutputs));
       for k = 1:numel(predictedOutputs)
           if predictedOutputs(k) >= 0.5
               predictedLabels(k) = 1;
           end
       end
       predictedLabels = predictedLabels';
       confusionMatrix = confusionmat(actualLabels', predictedLabels');
       TP = confusionMatrix(2,2);
       FP = confusionMatrix(1,2);
       FN = confusionMatrix(2,1);
       precision = TP/(TP+FP);
       recall = TP/(TP+FN);
       F1 = 2 * recall * precision / (precision + recall);
       newCsvData = [groupFolders(i) gestures(j) "Neural Network" precision recall F1];
       csvData = [csvData; newCsvData];
    end
    disp(csvData);
    return;
end

csvwrite("Statistics.csv", csvData);