function batchToVisualWords(numCores)
%David Fouhey
%CV Fall 2012 - Provided HW2 Code
%Does parallel computation of the visual words 
%
% Input:
%   numCores - number of cores to use (default 2)
tic;
if nargin < 1
    %default to 2 cores
    numCores = 2;
end


%Close the pools, if any
try
    fprintf('Closing any pools...\n');
    matlabpool close; 
catch
    %ignore any errors 
end

fprintf('Starting a pool of workers with %d cores\n', numCores);
matlabpool('local',numCores);

%load the files and texton dictionary
load('traintest.mat');
load('dictionary.mat');

source = 'data/';
target = 'dataProcessed/'; 

if(~exist(target))
    mkdir(target);
end

%This is a peculiarity of loading inside of a function with parfor. We need to 
%tell MATLAB that these variables exist and should be passed to worker pools.
filterBank = filterBank;
dictionary = dictionary;

%matlab can't save/load inside parfor; accumulate
%them and then do batch save
wordRepresentation = cell(numel(allFiles),1);
parfor i=1:numel(allFiles)
    fprintf('Converting to visual words %s is %g\n', allFiles{i},i);
    image = imread([source '/' allFiles{i} '.png']);
    wordRepresentation{i} = getVisualWords(image, filterBank, dictionary);
end

%dump the files
fprintf('Dumping the files\n');
for i=1:numel(allFiles)
    wordMap = wordRepresentation{i};
    save([target '/' allFiles{i} '.mat'],'wordMap');
end

%close the pool
fprintf('Closing the pool\n');
matlabpool close;
toc;
end
