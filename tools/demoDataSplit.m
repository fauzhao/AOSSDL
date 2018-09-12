function [test, cv] = demoDataSplit(kFold)
% Input:
%       fea: raw data(sampleNum x featureDim)
%       gnd: corresponding label(sampleNum x label)
% Output:
%       test. test set
%           test_x: 
%           test_y:
%       cv.: cross validation train set
%           train_x:
%           train_y:
%           valid_x:
%           valid_y:
% randomly split demo data
load('LFW_rand1573_pca500.mat') 
cv = struct([]);
test = struct([]);
for i = 1:kFold
    idx = i:10:size(train_x,2);
    Idx = 1:size(train_x,2);
    Idx(:,idx)=[];
    cv(i).valid_x = train_x(:,idx);
    cv(i).valid_y = train_y(:,idx);
    cv(i).train_x = train_x(:,Idx);
    cv(i).train_y = train_y(:,Idx);
    test(i).test_x = test_x;
    test(i).test_y = test_y;
end
end