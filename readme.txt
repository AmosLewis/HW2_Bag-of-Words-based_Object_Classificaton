%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
Carnegie Mellon University
Robotic Institute
16720 Computer Vision: Homework 2
Bag-of-Words-based Object Classificaton
Instructor: Martial Hebert
TAs: David Fouhey, Heather Knight and Daniel Maturana
Due Date: December 28th, 2016

/baseline
1 Computing Visual Words
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
[filterBank] = createFilterBank()

filterBank is a cell array2 We have also provided you with a function to extract filter
responses that takes a 3-channel RGB image and filter bank and returns the responses of
the filters on the image.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
[filterResponses] = extractFilterResponses(I, filterBank)

filterResponses is a N ¡Á M matrix, where N is the number of pixels in the input image,
and M is the number of filter responses (three times the size of the filter bank, since you
are applying it to a 3-channel image)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
[filterBank, dictionary] = getFilterBankAndDictionary(trainFiles)

to generate a dictionary given a list of images.
As an input, getFilterBankAndDictionary takes a cell array of strings containing the full path to an image. 

Once you have written getFilterBankAndDictionary, call the provided script computeDictionary, which will pass in the filenames, and go get a coffee. If all goes well, you will have a .mat file named dictionary.mat that contains the filter bank as well as the dictionary of visual words. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
[wordMap] = getVisualWords(I, filterBank, dictionary)

To map each pixel in the image to its closest word in the dictionary. 
wordMap is a matrix with the same width and height as I, where each pixel in wordMap is
assigned the closest visual word of the filter response at the respective pixel in I. 

Since this can be slow, we have provided a function batchToVisualWords(numberOfCores)
that will apply your implementation of the function getVisualWords to every image in the
training and testing set. This function will automatically5 use as many cores as you tell it
to use. For every image \X.png" in data/, there will be a corresponding file named \X.mat"
in dataProcessed/ containing the variable wordMap.

2 Building a Recognition System
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Extracting Features
[h] = getWindowFeatures(bbox, wordMap, dictionarySize)
As inputs, the function will take:
bbox = [minX, minY, maxX, maxY]
wordMap is a H ¡Á W image containing the ids of the visual words
dictionarySize is the maximum visual word id (i.e., the number of visual words)

As output, the function will return h, a dictionarySize ¡Á 1 histogram that is L1 normalized, (i.e., P hi = 1). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Comparing Windows
[histInter] = distanceToSet(wordHist, histograms)

where wordHist is a K ¡Á 1 histogram with K histogram bins and histograms is a K ¡Á T
matrix containing T histograms from T training samples concatenated along the columns.
This function returns the histogram intersection similarity between wordHist and each
training sample as a 1 ¡Á T vector. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Building A Model of the Visual World
buildRecognitionSystem.m 

Now that we¡¯ve made all of the components, we want to put everything that we will need at test-time together.We will need to load the training file names from traintest.mat and the filter bank and visual word dictionary from dictionary.mat. We will save everything to a matfile named vision.mat. 
Included will be:
1. filterBank: your filterbank.
2. dictionary: your visual word dictionary.
3. trainingInstances: a K¡ÁN matrix containing all of the histograms of the N training windows in the dataset. I have a dictionary with 150 words and my trainingInstances is 150 ¡Á 71853.
4. trainingLabels: a 1 ¡Á N vector containing the labels of each of the windows. (i.e., so that trainingInstances(:,i) has label trainingLabels(i)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
We have provided an interactive demo program that will let you click and get predictions on a new image. This will give you a visual sanity check that you have implemented things correctly. Use the program as follows:
demo2(absolutePathToImage), (e.g., demo2(¡¯fun/three.jpg¡¯))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Quantitative Evaluation
evaluateRecognitionSystem.m 
It tests the system and outputs the confusion matrix.


/custom
3 Improving Performance

Improving from 57% to 69% and 71%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
in folder custom/69
Better filter bank : add filters to your filter bank. Explain in my writeup what each filter (or class of filters) is supposed to pick up on. Add 3 families of filters.

%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
in folder custom/71
Better window similarity function : histogram intersection is nice, but there might be different distance and similarity metrics. We can use Hellinger.
