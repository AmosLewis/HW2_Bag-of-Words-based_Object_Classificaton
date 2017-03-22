function [ histInter ] = distanceToSet( wordHist, histograms )
%DISTANCETOSET 此处显示有关此函数的摘要
%  %将wordHist复制成histograms大小，求最小值 %求每一列和
%     histInter = sum(bsxfun(@min,wordHist,histograms),1);
    %%%%%%%%% improvement2 Hellinger distance %%%%%%%%%%%
    histInter = sqrt(sum((bsxfun(@minus,sqrt(wordHist),sqrt(histograms))).^2,1));
    %%%%%%%%% improvement2 Hellinger distance %%%%%%%%%%%
%   wordHist = repmat(wordHist,1,size(histograms,2));
%   histInter = sqrt(sum((sqrt(wordHist)-sqrt(histograms)).^2,1));
end

