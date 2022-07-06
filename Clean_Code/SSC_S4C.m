%--------------------------------------------------------------------------
% This is the function to call the sparse optimization program, to call the 
% spectral clustering algorithm and to compute the clustering error.
% r = projection dimension, if r = 0, then no projection
% affine = use the affine constraint if true
% s = clustering ground-truth
% missrate = clustering error
% CMat = coefficient matrix obtained by SSC
% W = weighted matrix
%--------------------------------------------------------------------------
% Copyright @ Ehsan Elhamifar, 2012
%--------------------------------------------------------------------------

function [grps,CMat] = SSC_S4C(X,r,affine,alpha,outlier,rho,s,l,lambda,alphass,M,N)

if (nargin < 6)
    rho = 1;
end
if (nargin < 5)
    outlier = false;
end
if (nargin < 4)
    alpha = 20;
end
if (nargin < 3)
    affine = false;
end
if (nargin < 2)
    r = 0;
end


n = l;


%% Optimization Program Parameters
Xp = DataProjection(X,r);
thr = 2*10^-4;
maxIter = 200; 

%% Run Optimization Program
if (~outlier)
    
    %S4C
    CMat = admmLasso_mat_func_S4C(Xp,affine,alpha,thr,maxIter,lambda,alphass,[],M,N);
    C = CMat;
else
    CMat = admmOutlier_mat_func_orig(Xp,affine,alpha,thr,maxIter,lambda);
    Nc = size(Xp,2);
    C = CMat(1:Nc,:);
end

%% Normalization of C Columns

% for i=1:length(C)
% C(:,i)=C(:,i)/max(C(:,i));
% end

%% Spectral Clustering
CKSym = BuildAdjacency(thrC(C,rho));
grps = SpectralClustering(CKSym,n);
grps = bestMapHS(grps,s);

end