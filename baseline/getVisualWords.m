function [ wordMap ] = getVisualWords( I, filterBank, dictionary )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   dictionary 100��*(3*33)������ ��Lab 3ͨ��
%   filterBank 1*33����
    [filterResponses] = extractFilterResponses(I,filterBank);%�������ص�*99
    I_gray = rgb2gray(I);
    %dis �� n(����)*100��
    dis = pdist2(filterResponses,dictionary,'seuclidean');%����filterResponsesÿһ�к�dictionary�����бȽ�
    [~,ID] = min(dis,[],2);%IDΪ������  n(����)*1 �ڲ�ֵΪdicÿ����Сֵ��Ӧ�б꣨���ࣩ
    wordMap = uint8(reshape(ID,size(I_gray,1),size(I_gray,2)));
end

