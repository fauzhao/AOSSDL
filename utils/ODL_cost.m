function cost = ODL_cost(Y, D, X, lambda)
%% =================== Description ============================================
% calc construction error from the learned dictionary
%% ============================================================================
	cost = 0.5*normF2(Y - D*X) + lambda*norm1(X);
end 