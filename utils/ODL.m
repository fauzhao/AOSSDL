function [D, X] = ODL(Y, k, lambda, opts, method)
%% ========= Online Dictionary Learning =======================================
% * Solving the following problem:
%  (D, X) = \arg\min_{D,X} 0.5||Y - DX||_F^2 + lambda||X||_1
% * Syntax: `[D, X] = ODL(Y, k, lambda, opts, sc_method)`
%   - INPUT: 
%     + `Y`: collection of samples.
%     + `k`: number of atoms in the desired dictionary.
%     + `lambda`: norm 1 regularization parameter.
%     + `opts`: option.
%     + `sc_method`: sparse coding method used in the sparse coefficient update. Possible values:
%       * `'fista'`: using FISTA algorithm. See also [`fista`](#fista).
%       * `'spams'`: using SPAMS toolbox [[12]](#fn_spams). 
%   - OUTPUT:
%     + `D, X`: as in the problem.
%% ============================================================================
	opts = initOpts(opts);
	%% ========= initial D ==============================
	D = PickDfromY(Y, [0, size(Y,2)], k);
    X = zeros(size(D,2), size(Y,2));
    if opts.verbose 
        fprintf('cost: %f', ODL_cost(Y, D, X, lambda));
    end 
    optsX = opts;
	optsX.max_iter = 500;
	optsX.tol      = 1e-8;
    optsD = opts;
	optsD.max_iter = 500;
	optsD.tol      = 1e-8;
	iter = 0;
	while iter < opts.max_iter
		iter = iter + 1;
		%% ========= sparse coding step ==============================
		X = lasso_fista(Y, D, X, lambda, optsX);
       	if opts.verbose 
            costX = ODL_cost(Y, D, X, lambda);
            fprintf('iter: %3d, costX = %5f\n', iter, costX);
        end 
		%% ========= dictionary update step ==============================
		F = X*X'; E = Y*X';
		D = ODL_updateD(D, E, F, optsD);
		if opts.verbose 
			costD = ODL_cost(Y, D, X, lambda);
			fprintf('iter: %3d, costD = %5f\n', iter, costD);
		end 
	end
	%%
	if nargin == 0
		pause;
	end
end
