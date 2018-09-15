function X = shrinkage(U, lambda)
%% =================== Description =========================
% Description: Solve $X = \arg\min 0.5*||X - U||_F^2 + \lambda ||X||_1$
%% =========================================================
X = max(0, U - lambda) + min(0, U + lambda);
end
	
