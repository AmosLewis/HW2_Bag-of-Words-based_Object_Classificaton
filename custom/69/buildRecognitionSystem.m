    tic;
    load('traintest.mat');
    load('dictionary.mat');
    
    toProcess = {};
    toProcess1 = {};
    toProcess2 = {};
    trainingInstances = [];
    trainingLabels = [];
    for i=1:numel(trainingFiles)
        toProcess{i} = ['bboxes/' trainingFiles{i} '.bboxes.txt']; %%·��
        M = dlmread(toProcess{i});
        for j =1:size(M,1)%����ÿ��bboxes,������п��hist ����bboxes�е�hist����trainingInstances
            bbox=M(j,:);
            toProcess1{i} = ['dataProcessed/' trainingFiles{i} '.mat']; 
            load(toProcess1{i}); %%����wordMap
            h = getWindowFeatures( bbox, wordMap, size(dictionary,1) );%��ø�wordMap��hist
            trainingInstances =[trainingInstances,h];%%��hist
        end
        %����bboxes�е����д��ڶ�Ӧ����ȷ��label����trainingLabels%
        toProcess2{i} = ['bboxes/' trainingFiles{i} '.ids.txt']; 
        N = dlmread(toProcess2{i})';
        trainingLabels =[trainingLabels,N];  
        fprintf('Converting to visual words %g\n',i);
    end
    save('vision.mat','filterBank','dictionary','trainingInstances','trainingLabels');
    toc;