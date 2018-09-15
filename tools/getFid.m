function [fid]=getFid(datasetName)
%% =================== Description ============================================
% Input:
%		datasetName: e.g. LFW denotes the LFW face datasetName
% Output:
%		fid: result file's handler
% Description:
%		return a result file handler
%% ============================================================================
%% use different delimiter under different os
[status, ~]=system('systeminfo'); 
if status==0 
	delimiter='\';
else
	delimiter='/';
end
%% use date and time to name a result file
now = clock;
resultFolder = char(['result',delimiter,sprintf('%02d',now(:,1:3))]);
if ~exist(resultFolder,'dir')
    mkdir(resultFolder);
end
resultFile = char(join([resultFolder,delimiter,datasetName,'_',sprintf('%02d',now(:,4:5)),'.txt'],''));
if ~exist(resultFile,'file')
    fid = fopen(resultFile,'a');
    fprintf(fid,'%s\n','==============================================');
else
    fid = fopen(resultFile,'a');
end
end