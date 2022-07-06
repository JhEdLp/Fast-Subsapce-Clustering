%%  Spectral-Spatial subspace clustering using Superpixels and DL
%
%   Routine: Build U Matrix
%
%   Author:
%   Carlos Hinojosa
%   Universidad Industrial de Santander, Bucaramanga, Colombia
%   email: carlos.hinojosa@saber.uis.edu.co
%
%   Description:
%   %
%   Copyright Carlos Hinojosa @ Universidad Industrial de Santander
%   Date: November, 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [U,W,sortedData] = build_Dmatrix(groups,Ngroups,Npoints,sortFlag,data)
% crete segmentation matrix
val1          = [];
val2          = [];
idxx          = [];
idxy          = [];
sortedData    = [];
if ~isvector(groups)
    groups = groups(:);
end

if(sortFlag)
   [groups,Isort] = sort(groups);
    sortedData = data(Isort,:);
end

for nseg = 1:Ngroups
    idx       = find(groups == nseg);
    idxx      = [idxx; idx];
    idxy      = [idxy; ones(length(idx), 1)*nseg];
    val1      = [val1; ones(length(idx), 1)];
    val2      = [val2; 1./length(idx)];
end
U             = sparse(idxy, idxx, val1, Ngroups, Npoints);  %matriz sparse de unos
W             = sparse(1:Ngroups, 1:Ngroups, val2, Ngroups, Ngroups);
%Uw            = W*U;
end