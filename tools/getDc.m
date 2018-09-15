function Dc = getDc(D, D_ls, c)
%% =================== Description ============================================
% description: get c-th class atoms of D
%% ============================================================================
    Dc = D(:,D_ls==c);
end