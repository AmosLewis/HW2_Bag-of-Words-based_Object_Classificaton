% 
%     
%     K =200;
%     a = 100;
%     A = ceil(rand(a,1)*68160); 
%     [filterBank] = createFilterBank();
%     filterResponses1 = [];
%     I = imread(['data/' trainingFiles{1} '.png']);
%     [filterResponses] = extractFilterResponses(I,filterBank);
%     filterResponses1 = [filterResponses1;filterResponses(A,:)];
%     
%     I = imread(['data/' trainingFiles{2} '.png']);
%     [filterResponses] = extractFilterResponses(I,filterBank);
%     filterResponses1 = [filterResponses1;filterResponses(A,:)];


%%getVisualWords.m%%%
%     load('traintest.mat');
%     load('dictionary.mat')
%     I = imread(['data/' trainingFiles{1} '.png']);
%     [filterResponses] = extractFilterResponses(I,filterBank);
%     I_gray = rgb2gray(I);
%     dis = pdist2(filterResponses,dictionary,'seuclidean');
%     [~,ID] = min(dis,[],2);
% %     index = [];   
% %      for pixelCount = 1:size(I_gray,1)*size(I_gray,2)
% %           disN = dis(pixelCount,:);
% %           Location= find(disN==min(disN));    
% %           index =[index,Location];
% %      end 
% %      wordMap=uint8(reshape(index,size(I_gray,1),size(I_gray,2)));
%      wordMap=uint8(reshape(ID,size(I_gray,1),size(I_gray,2)));
%      imshow(wordMap);
    

%%%%%%%%%%%%getWindowFeatures%%%%%%%%%%%%%
dictionarySize = 100;
bboxes =int32(load('bboxes/1_1_s.bboxes.txt'));
bbox=bboxes(1,:);
load('dataProcessed/1_1_s.mat');

wordmap = double(wordMap(bbox(2):bbox(4),bbox(1):bbox(3)));
wordmap = reshape(wordmap,1,size(wordmap,1)*size(wordmap,2));
H = hist(wordmap,dictionarySize);
S = sum(H);
h = H'/sum(H');
s = sum(h);

%%%%%%[ histInter ] = distanceToSet( wordHist, histograms )%%%%%%%
wordHist = h;%测试图的直方图
histograms = [0.4*ones(100,5),0.01*ones(100,5)];%调试矩阵
% hinterm = bsxfun(@min,wordHist,histograms);%将wordHist复制成histograms大小，求最小值
% histInter = sum(bsxfun(@min,wordHist,histograms),1);  %求每一列和
wordHist = repmat(wordHist,1,size(histograms,2));
histInter = sqrt(sum((sqrt(wordHist)-sqrt(histograms)).^2));
% histInter = sqrt(sum((bsxfun(@minus,sqrt(wordHist),sqrt(histograms))).^2,1));





    
    
    