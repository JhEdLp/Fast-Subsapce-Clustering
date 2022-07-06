function Xp = dimReduction(X, dim)
%DIMREDUCTION_PCA Dimension reduction by PCA.
% 	XP = dimReduction_PCA(X,DIM) computes DIM-dimensional embedding by PCA.
%   Let X = U D V' be its SVD where the singular values in D are ordered. 
%   XP is computed as the first DIM rows of D * V'.

% Input Arguments
% X                 -- data matrix of size D by N.
% dim               -- dimension
% Output Arguments
% Xp                -- data matrix of size dim by N.

% Copyright Chong You @ Johns Hopkins University, 2016
% chong.you1987@gmail.com


if dim == 0
    Xp = X;
    return;
end

[~,score,~] = pca(X', 'centered', false, 'NumComponents', dim);
Xp = score';

% In case of N >> D and out-of-memory, use the following (should be equivalent to above)
% M = X * X';
% [U, D] = eig(M);
% [~, ord] = sort(real(diag(D)), 'descend');
% Xp = U(:, ord(1:dim))' * X;

end
            
