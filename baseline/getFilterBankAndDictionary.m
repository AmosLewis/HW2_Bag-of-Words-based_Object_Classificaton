function [ filterBank, dictionary ] = getFilterBankAndDictionary( trainFiles )
%GETFILTERBANKANDDICTIONARY �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    K =100;%K ����
    a = 100;%������ͼ��ȡ100�����ؼ���
    
    [filterBank] = createFilterBank();%����99��filter
    filterResponses1 = [];%��������ѵ��ͼ���ȡ������ļ��ϣ�����kmeans ���룬Ϊ99��
    for i =1:numel(trainFiles)
        I = imread(trainFiles{i});
        [filterResponses] = extractFilterResponses(I,filterBank);% number of pixels * number of filter response 99
       % A = ceil(rand(a,1)*68160); %ȡ�����100������
        A = randperm(size(filterResponses,1),a);%���ȡ�����100�����ص�������
        filterResponses1 = [filterResponses1;filterResponses(A,:)];    % 100T * number of filter response 99
    end
    [ignore,dictionary] = kmeans(filterResponses1, K, 'EmptyAction','drop');
end

