function Plabel=OutSample(Tr_dat, Tt_dat, Tr_plabel)
% using CRC
kappa = 1e-6;
Proj_M = (Tr_dat'*Tr_dat+kappa*eye(size(Tr_dat,2)))\Tr_dat';
%         Proj_M = inv(Tr_dat'*Tr_dat+kappa*eye(size(Tr_dat,2)))*Tt_dat';
for indTest = 1:size(Tt_dat,2)
    Plabel(indTest) = CRC_IDcheck(Tr_dat,Proj_M,Tt_dat(:,indTest),Tr_plabel);
end
end