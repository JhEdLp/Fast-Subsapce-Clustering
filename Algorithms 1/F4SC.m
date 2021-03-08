function [Xmember,Ymember,log]=F4SC(F,hyperimg_gt,bordes,Nb)

F1=F(:,Nb);
F2=F(:,bordes);
s1=hyperimg_gt(Nb);
s2=hyperimg_gt(bordes);


F1 = F1 - mean(F1(:));
F1 = F1./std(F1(:));

F2 = F2 - mean(F2(:));
F2 = F2./std(F2(:));

p=length(Nb);
[a,b]=multi(p);

l = length(unique(s1))-1;% number of clusters que tienen los datos
% l = TSC(F1,a);

if l == 0
    l = TSC(F1,a);
end
    
try   
    alpha = 1000;
    %alpha = [1400,1000];
    r = 0; % data projection
    affine = true; % affine constraint
    outlier = false; % data has outlier
    rho = 0.7; 

    la = 7.76e-7; % sparsity/noise tradeoff
    alphass = 0.05 ;%[3.0 4.2] ;  % spectral/spatial tradeoff
    
    %% SCC Algorithm for In sample Data
    [Xmember,C] = SSC_S4C(F1,r,affine,alpha,outlier,rho,s1,l,la,alphass,a,b);

    %% Out-of-sample membership
    Ymember = OutSample(F1,F2,Xmember);
    Ymember = Ymember';
    log=1;
    
    if (~isempty(find(Xmember==0, 1)))
        
        a = find(Xmember==0);
        q = unique(Xmember);
%         Xmember(a) = q(2);
        Xmember(a) = randi(9)+1; 
%         Xmember(a) = 2;
    end

catch
    
    log=0;
    Xmember=[];
    Ymember=[];
    
end


end
