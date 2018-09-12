function [acc] = getAcc(tt,tt_ls,D,D_ls,X,opts)
% nClass = numel(tt_ls);
nTest = size(tt,2);
nCorrect = 0;
% X = lasso_fista(tt,D,[],opts.lambda,opts);
for i = 1:nTest
    y = tt(:,i);
    y_ls = tt_ls(:,i);
    %% Local 
%     for c = 1:nClass
%         Dc = getDc(D, D_ls, c);
%         Xc = lasso_fista(y,Dc,[],opts.lambda,opts);
%         R1 = y - Dc*Xc;
%         E(c,:) = 0.5* sum(R1.^2, 1) + opts.lambda*sum(abs(Xc),1);
%     end
    %% Global
    R1 = y - D*X;
    E = 0.5* sum(R1.^2, 1) + opts.lambda*sum(abs(X),1);
    [~, pred] = min(E);
    if D_ls(pred) == y_ls
        nCorrect = nCorrect + 1;
    end
end
acc = nCorrect/nTest;
end