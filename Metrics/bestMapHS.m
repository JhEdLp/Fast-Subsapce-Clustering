function [new_g] = bestMapHS(groups,labels)
%bestMapHS: When classifying HS images, the background is not taken
%into account as a class. This function permute labels of L2 to match L1 
%as good as possible in the case of HS image clustering. This function is
%based on the bestMap algorithm written by Deng Cai (dengcai AT gmail.com)
%
%   [newL2] = bestMapHS(L1,L2);
%
%   version 1.0 --October/2019
%
%   Written by Carlos Hinojosa (carlos.hinojosa AT saber.uis.edu.co)
%========================================================================%

new_g = bestMap(labels, groups);
crV=[];
u1= unique(labels);
u1(1)=[];
u2 = unique(new_g);

for ii =1:length(u1)
    if ~ismember(u1(ii),u2)
        crV = u1(ii);
        break;
    end
end

if ~isempty(crV)
    new_g(new_g==1)=crV;
else
    new_g(new_g==1)=randi(9)+1;
end

new_g = new_g';
end