function [D, iter] = ODL_updateD(D, E, F, opts)    
%% =================== Description ============================================
% * The main algorithm in ODL. 
% * Solving the optimization problem:
%   `D = arg min_D -2trace(E'*D) + trace(D*F*D')` subject to: `||d_i||_2 <= 1`,
%      where `F` is a positive semidefinite matrix. 
% * Syntax `[D, iter] = ODL_updateD(D, E, F, opts)`
%   - INPUT: 
%     + `D, E, F` as in the above problem.
%     + `opts`. options:
%       * `opts.max_iter`: maximum number of iterations.
%       * `opts.tol`: when the difference between `D` in two successive 
%			iterations less than this value, the algorithm will stop.
%   - OUTPUT:
%     + `D`: solution.
%     + `iter`: number of run iterations.
%% ============================================================================
    function cost = calc_cost(D)
        cost = -2*trace(E*D') + trace(F*(D'*D));
    end 
    opts = initOpts(opts);
	Dold = D;
	iter = 0;
	sizeD = numel(D);
    while (iter < opts.max_iter)	
        iter = iter + 1;
        for i = 1: size(D,2)
            if(F(i,i) ~= 0)
				a = 1.0/F(i,i) * (E(:,i) - D*F(:, i)) + D(:,i);
				D(:,i) = a/(max( norm(a,2),1));			
            end
        end	  
        if opts.verbose
            fprintf('iter: %3d | cost = %.4f, tol = %f\n', iter, calc_cost(D), norm(D - Dold, 'fro')/sizeD);
        end
		%% check stop condition
		if (norm(D - Dold, 'fro')/sizeD < opts.tol)
			break;
		end
		Dold = D;		
    end
end 