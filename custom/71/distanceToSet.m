function [ histInter ] = distanceToSet( wordHist, histograms )
%DISTANCETOSET �˴���ʾ�йش˺�����ժҪ
%  %��wordHist���Ƴ�histograms��С������Сֵ %��ÿһ�к�
%     histInter = sum(bsxfun(@min,wordHist,histograms),1);
    %%%%%%%%% improvement2 Hellinger distance %%%%%%%%%%%
    histInter = sqrt(sum((bsxfun(@minus,sqrt(wordHist),sqrt(histograms))).^2,1));
    %%%%%%%%% improvement2 Hellinger distance %%%%%%%%%%%
%   wordHist = repmat(wordHist,1,size(histograms,2));
%   histInter = sqrt(sum((sqrt(wordHist)-sqrt(histograms)).^2,1));
end

