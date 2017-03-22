function [ filterBank, dictionary ] = getFilterBankAndDictionary( trainFiles )
%GETFILTERBANKANDDICTIONARY 此处显示有关此函数的摘要
%   此处显示详细说明
    K =100;%K 个类
    a = 100;%对任意图像取100个像素计算
    
    [filterBank] = createFilterBank();%创造99个filter
    filterResponses1 = [];%最终所有训练图像的取特征后的集合，用于kmeans 输入，为99列
    for i =1:numel(trainFiles)
        I = imread(trainFiles{i});
        [filterResponses] = extractFilterResponses(I,filterBank);% number of pixels * number of filter response 99
       % A = ceil(rand(a,1)*68160); %取出随机100个像素
        A = randperm(size(filterResponses,1),a);%随机取出随机100个像素的行坐标
        filterResponses1 = [filterResponses1;filterResponses(A,:)];    % 100T * number of filter response 99
    end
    [ignore,dictionary] = kmeans(filterResponses1, K, 'EmptyAction','drop');
end

