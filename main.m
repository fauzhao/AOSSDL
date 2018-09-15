close all;
clear;
clc;
dbstop if error;
addpath('tools');
addpath('utils');
addpath('data');
%% load data
kFold = 10;
[test, cv] = demoDataSplit(kFold);
%% setup log
datasetName = 'LFW';
[fid]=getFid(datasetName);
%% train and test
for lambda = 0.01%[0.01 0.05 0.1 0.2 0.3 0.4 0.5]
    fprintf(['==============  Starting  =====================', '\n\n']);
    validAcc = [];
    testAcc = [];
    t1 = clock;
    for fold = 1:kFold
        %% training
        fprintf(['==============  Training  =====================', '\n']);
        tic;
        opts.lambda = lambda;
        opts.method = 'fista';
        opts.max_iter = 100;
        opts.verbose = 0;
		opts.tol = 1e-8;
		opts.check_grad = false;
        train_x = cv(fold).train_x;
        train_y = cv(fold).train_y;
        k = size(train_x, 2);
        [D, X] = ODL(train_x, k, opts.lambda, opts, opts.method);
        fprintf(2,['Time=',num2str(toc/60),' Min','\n']);
        %% testing
        fprintf(['==============  Testing   =====================', '\n']);
        tic;
        %% valid
        valid_x = cv(fold).valid_x;
        valid_y = cv(fold).valid_y;
        [validAcc] = [validAcc getAcc(valid_x,valid_y,D,train_y,X,opts)];
        fprintf(2,'%s=%d\t%s=%.4f\t','fold',fold,'valid',validAcc(fold));
        fprintf(fid,'%s=%d\t%s=%.4f\t','fold',fold,'valid', validAcc(fold));
        %% test
        test_x = test(fold).test_x;
        test_y = test(fold).test_y;
        [testAcc] = [testAcc getAcc(test_x,test_y,D,train_y,X,opts)];
        fprintf(2,'%s=%.4f\n','test',testAcc(fold));
        fprintf(fid,'%s=%.4f\n','test',testAcc(fold));
        fprintf(2,['Time=',num2str(toc/60),' Min','\n']);
    end
    fprintf(fid,'%s=%.3f\t%s=%.4f Min\n','lambda',opts.lambda,'time',etime(clock,t1)/60);
    fprintf(fid,'Valid\t%s=%.4f\t%s=%.4f','mean',mean(validAcc),'std',std(validAcc));
    fprintf(fid,'\nTest\t%s=%.4f\t%s=%.4f\n','mean',mean(testAcc),'std',std(testAcc));
    fprintf(fid,'%s\n','==============================================');
end
%% finish
fprintf(['==============  Finish  =======================', '\n']);
load chirp;
sound(y, Fs);
clear y Fs;