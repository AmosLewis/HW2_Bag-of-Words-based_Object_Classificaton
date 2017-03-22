    tic;
    load('traintest.mat');
    load('dictionary.mat');
    load('vision.mat');
    
    toProcess = {};
    toProcess1 = {};
    toProcess2 = {};
    testInstances = [];
    testLabels = [];
    predictLabels = [];
    for i=1:numel(testingFiles)
        toProcess{i} = ['bboxes/' testingFiles{i} '.bboxes.txt']; %%testFiles路径
        M = dlmread(toProcess{i});
        for j =1:size(M,1)%对于每个bboxes,求出所有框的hist 所有bboxes中的hist存入testInstances
            bbox=M(j,:);
            toProcess1{i} = ['dataProcessed/' testingFiles{i} '.mat']; 
            load(toProcess1{i}); %%载入wordMap
            h = getWindowFeatures( bbox, wordMap, size(dictionary,1) );%获得该wordMap的hist
            distances = distanceToSet( h, trainingInstances );%每一个test 与 training比较，算出his每一列重合的部分
            [~,nnI] = max(distances);
            predictLabel = trainingLabels(nnI);
            predictLabels = [predictLabels,predictLabel];%预测出的label,可能为假
            testInstances =[testInstances,h];%%存测试集的hist
        end
        %所有bboxes中的所有测试窗口对应的正确labels存入testLabels%
        toProcess2{i} = ['bboxes/' testingFiles{i} '.ids.txt']; 
        N = dlmread(toProcess2{i})';
        testLabels =[testLabels,N];  
        fprintf('Converting to visual words %g\n',i);
    end
    C = zeros(13,13);
    ID = sub2ind(size(C),testLabels,predictLabels);%测试集labels为行坐标，表示输入，预测集labels表示纵坐标，表示输出 
    for i=1:size(ID,2)
        C(ID(1,i))=C(ID(1,i))+1;
    end
    accuracy = trace(C)/sum(C(:));%%算正确率
    save('evaluate.mat','testLabels','predictLabels','C','accuracy','testInstances');
    toc;
    
    
    