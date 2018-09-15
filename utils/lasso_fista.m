function [X, iter] = lasso_fista(Y, D, Xinit, lambda, opts)
%% =================== Description ============================================
% * Solving a Lasso problem using FISTA [[11]](#fn_fista): 
%           `X = arg min_X 0.5*||Y - DX||_F^2 + lambda||X||_1`. 
%   Note that `lambda` can be either a positive scalar or a matrix with 
%   positive elements.
% * Syntax: `[X, iter] = lasso_fista(Y, D, Xinit, lambda, opts)`
%   - INPUT:
%     + `Y, D, lambda`: as in the problem.
%     + `Xinit`: Initial guess 
%     + `opts`: options. 
%   - OUTPUT:
%     + `X`: solution.
%     + `iter`: number of fistat iterations.
%% ============================================================================
%% cost tool function 
function cost = calc_f(X)
    cost = 1/2 *normF2(Y - D*X);
end 
%% cost function 
function cost = calc_F(X)
    if numel(lambda) == 1 % scalar 
        cost = calc_f(X) + lambda*norm1(X);
    elseif numel(lambda) == numel(X)
        cost = calc_f(X) + norm1(lambda.*X);
    end
end 
%% gradient
DtD = D'*D;
DtY = D'*Y;
function res = grad(X) 
    res = DtD*X - DtY;
end
%%
L = max(eig(DtD));
[X, iter] = fista(@grad, Xinit, L, lambda, opts, @calc_F);
end 