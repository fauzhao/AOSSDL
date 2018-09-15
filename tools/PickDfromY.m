function D = PickDfromY(Y, Y_range, k)
%% ========================= Description ======================================
% Input:
% 		Y: training sample set (featureDim x sampleNum)
% 		Y_range: atoms select from the Y_range of Y
% 		k: number of atoms in the desired dictionary.
% Outpu:
%		D: init D atoms select from Y(training sample set)
% Description:
%		Initialize $D_{ini}$ according to pre-defined range of training sample set.
%% ============================================================================
C = numel(Y_range) - 1;
D = [];
for i = 1: C
	range = Y_range(i) + 1 : Y_range(i+1);
	Yi = Y(:, range);
	Ni = size(Yi,2);
	ids = randperm(Ni);
	[D] = [D, Yi(:, ids(1:k))];
end
end