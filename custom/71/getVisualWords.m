function [ wordMap ] = getVisualWords( I, filterBank, dictionary )
%UNTITLED 此处显示有关此函数的摘要
%   dictionary 100类*(3*33)个特征 ；Lab 3通道
%   filterBank 1*33特征
    [filterResponses] = extractFilterResponses(I,filterBank);%所有像素点*99
    I_gray = rgb2gray(I);
    %dis 是 n(像素)*100类
    dis = pdist2(filterResponses,dictionary,'seuclidean');%计算filterResponses每一行和dictionary所有行比较
    [~,ID] = min(dis,[],2);%ID为列向量  n(像素)*1 内部值为dic每行最小值对应列标（即类）
    wordMap = uint8(reshape(ID,size(I_gray,1),size(I_gray,2)));
end

