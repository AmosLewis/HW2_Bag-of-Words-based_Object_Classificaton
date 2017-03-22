function colorImage = msrcVis(idMap)
%David Fouhey
%CV Fall 2012 - Provided HW2 Code
%Takes a map of predicted ids, and colors it ala MSRC.
    [h,w] = size(idMap);
    colors = [  128, 0, 0;
                0, 128, 0;
                128, 128, 0;
                0, 0, 128;
                128, 0, 128;
                0, 128, 128;
                128, 128, 128;
                64, 0, 0;
                192, 0, 0;
                64, 128, 0;
                192, 128, 0;
                64, 0, 128;
                192, 0, 128];
    colorImage = zeros([h,w,3]);
    for colorI=1:size(colors)
        mask = idMap == colorI;
        for c=1:3
            chan = colorImage(:,:,c);
            chan(mask) = chan(mask) + colors(colorI,c);
            colorImage(:,:,c) = chan;
        end 
    end
    colorImage = uint8(colorImage);
end
