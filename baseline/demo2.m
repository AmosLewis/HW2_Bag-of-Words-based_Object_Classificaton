%David Fouhey
%CV Fall 2012 - Provied HW2 
%Input:
%   imageName: a filename for an image
function demo2(imageName)
    names = {'building','grass','tree','cow','horse','sheep','sky','mountain','aeroplane','water','face','car','bicycle'};
    if(~exist(imageName))
        fprintf('No such image!\n');
        return;
    end
    load('vision.mat');
    fprintf('[Loading]\n');
    image = imread(imageName);
    imshow(image);
    imageHeight = size(image,1); imageWidth = size(image,2);
    fprintf('[Getting Visual Words]\n');
    wordMap = getVisualWords(image, filterBank, dictionary);
    while(1)
        %get user input
        try
            R = getrect;
        catch
            fprintf('All done?\n');
            break;
        end
        %make sure the bounding box is sensible
        minX = R(1); minY = R(2); maxX = R(1)+R(3); maxY = R(2)+R(4);
        minX = fix(max(1,minX)); minY = fix(max(1,minY)); 
        maxX = fix(min(imageWidth,maxX)); maxY = fix(min(imageHeight,maxY));

        %classify the window
        h = getWindowFeatures([minX,minY,maxX,maxY], wordMap, size(dictionary,1));

        %Nearest neighbor!
        distances = distanceToSet(h, trainingInstances);
        [~,nnI] = max(distances);
        prediction = trainingLabels(nnI);
        fprintf('Prediction: %s\n',names{prediction});
    end 
end
