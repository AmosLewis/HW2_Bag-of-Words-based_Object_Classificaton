function [ histInter ] = distanceToSet( wordHist, histograms )
%DISTANCETOSET 
%  %��wordHist���Ƴ�histograms��С������Сֵ %��ÿһ�к�
    histInter = sum(bsxfun(@min,wordHist,histograms),1);
end

