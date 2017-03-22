%David Fouhey
%CV Fall 2012 - Provided HW2 code
%Does computation of the filter bank and dictionary, and saves
%it in dictionary.mat
%
tic;
load('traintest.mat');
toProcess = {};
%give the absolute path
for i=1:numel(trainingFiles)
    toProcess{i} = ['data/' trainingFiles{i} '.png']; 
end
[filterBank,dictionary] = getFilterBankAndDictionary(toProcess);
save('dictionary.mat','filterBank','dictionary');
toc;

