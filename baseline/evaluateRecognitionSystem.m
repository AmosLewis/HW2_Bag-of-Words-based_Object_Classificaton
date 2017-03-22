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
        toProcess{i} = ['bboxes/' testingFiles{i} '.bboxes.txt']; %%testFiles·��
        M = dlmread(toProcess{i});
        for j =1:size(M,1)%����ÿ��bboxes,������п��hist ����bboxes�е�hist����testInstances
            bbox=M(j,:);
            toProcess1{i} = ['dataProcessed/' testingFiles{i} '.mat']; 
            load(toProcess1{i}); %%����wordMap
            h = getWindowFeatures( bbox, wordMap, size(dictionary,1) );%��ø�wordMap��hist
            distances = distanceToSet( h, trainingInstances );%ÿһ��test �� training�Ƚϣ����hisÿһ���غϵĲ���
            [~,nnI] = max(distances);
            predictLabel = trainingLabels(nnI);
            predictLabels = [predictLabels,predictLabel];%Ԥ�����label,����Ϊ��
            testInstances =[testInstances,h];%%����Լ���hist
        end
        %����bboxes�е����в��Դ��ڶ�Ӧ����ȷlabels����testLabels%
        toProcess2{i} = ['bboxes/' testingFiles{i} '.ids.txt']; 
        N = dlmread(toProcess2{i})';
        testLabels =[testLabels,N];  
        fprintf('Converting to visual words %g\n',i);
    end
    C = zeros(13,13);
    ID = sub2ind(size(C),testLabels,predictLabels);%���Լ�labelsΪ�����꣬��ʾ���룬Ԥ�⼯labels��ʾ�����꣬��ʾ��� 
    for i=1:size(ID,2)
        C(ID(1,i))=C(ID(1,i))+1;
    end
    accuracy = trace(C)/sum(C(:));%%����ȷ��
    save('evaluate.mat','testLabels','predictLabels','C','accuracy','testInstances');
    toc;
    
    
    