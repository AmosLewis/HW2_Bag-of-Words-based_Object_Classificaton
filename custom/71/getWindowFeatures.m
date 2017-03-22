function [ h ] = getWindowFeatures( bbox, wordMap, dictionarySize )
%GETWINDOWFEATURES �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    wordmap = double(wordMap(bbox(2):bbox(4),bbox(1):bbox(3)));%ȡ��һ����������Ԫ��
    wordmap = reshape(wordmap,1,size(wordmap,1)*size(wordmap,2));%����һ�� ����hist����
    H = hist(wordmap,dictionarySize); %��ֱ��ͼ
    h = H'/sum(H');  %��һ��
end



