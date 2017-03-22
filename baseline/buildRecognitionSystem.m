    tic;
    load('traintest.mat');
    load('dictionary.mat');
    
    toProcess = {};
    toProcess1 = {};
    toProcess2 = {};
    trainingInstances = [];
    trainingLabels = [];
    for i=1:numel(trainingFiles)
        toProcess{i} = ['bboxes/' trainingFiles{i} '.bboxes.txt']; %%路径
        M = dlmread(toProcess{i});
        for j =1:size(M,1)%对于每个bboxes,求出所有框的hist 所有bboxes中的hist存入trainingInstances
            bbox=M(j,:);
            toProcess1{i} = ['dataProcessed/' trainingFiles{i} '.mat']; 
            load(toProcess1{i}); %%载入wordMap
            h = getWindowFeatures( bbox, wordMap, size(dictionary,1) );%获得该wordMap的hist
            trainingInstances =[trainingInstances,h];%%存hist
        end
        %所有bboxes中的所有窗口对应的正确的label存入trainingLabels%
        toProcess2{i} = ['bboxes/' trainingFiles{i} '.ids.txt']; 
        N = dlmread(toProcess2{i})';
        trainingLabels =[trainingLabels,N];  
        fprintf('Converting to visual words %g\n',i);
    end
    save('vision.mat','filterBank','dictionary','trainingInstances','trainingLabels');
    toc;