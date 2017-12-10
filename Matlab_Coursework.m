data = importdata('sortedData.txt');
inputData = data(:,2:10);
targetData = data(:,11);
trainingdatainput12 = inputData(1:(150)/2,:);
trainingdatainput14 = inputData((size(inputData)-(150)/2)+1:size(inputData),:);
trainingdataoutput12 = targetData(1:(150)/2,:);
trainingdataoutput14 = targetData((size(targetData)-(150)/2)+1:size(targetData),:);
inputData1 = cat(1,trainingdatainput12,trainingdatainput14);
targetData1 = cat(1,trainingdataoutput12,trainingdataoutput14);
testingData = inputData(((150)/2)+1:(size(inputData)-(150)/2),:);
testingTargetData = targetData(((150)/2)+1:(size(targetData)-(150)/2),:);
net = newff(inputData1',targetData1',4  , {'tansig' 'tansig'}, 'trainr', 'learngd', 'mse');
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.2;
net.trainParam.max_fail = 20;
net = train(net,inputData1',targetData1');
result = net(testingData');
count = 0;
result = result';
    for i=1:size(result)
        if(result(i)<=3)
             result(i)=2;
        else
             result(i)=4;
        end
        if(testingTargetData(i)==result(i))
             count = count+1;
        end
     end
Accuracy = (count/size(result,1))*100;