function [ h ] = getWindowFeatures( bbox, wordMap, dictionarySize )
%GETWINDOWFEATURES 此处显示有关此函数的摘要
%   此处显示详细说明
    wordmap = double(wordMap(bbox(2):bbox(4),bbox(1):bbox(3)));%取得一个框中所有元素
    wordmap = reshape(wordmap,1,size(wordmap,1)*size(wordmap,2));%拉成一行 用于hist输入
    H = hist(wordmap,dictionarySize); %做直方图
    h = H'/sum(H');  %归一化
end



