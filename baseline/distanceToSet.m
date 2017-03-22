function [ histInter ] = distanceToSet( wordHist, histograms )
%DISTANCETOSET 
%  %将wordHist复制成histograms大小，求最小值 %求每一列和
    histInter = sum(bsxfun(@min,wordHist,histograms),1);
end

