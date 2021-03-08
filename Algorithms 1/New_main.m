function [grps,log]=New_main(hyperimg,hyperimg_gt,indices,indices1)

aux=zeros(length(indices),1);
aux(find(indices1))=0.1;
a=find(~aux);
indices2=indices(a);

[M,N,L]=size(hyperimg);
s = hyperimg_gt(:);

F = reshape(hyperimg,[M*N,L])';
% F = F(:,indices);
% s=s(indices);
[M,N]=size(F);
%% Normalization

F = F - mean(F(:));
F = F./std(F(:));

%% Seleccionar data fuera de los bordes

% Xtemp = F;
% stemp = s;

% aca p es un vector con posiciones o columnas que se van seleccionar
% entonces aca p debe contenter los indices que hacen referencia a los
% datos que vamos a usar para hacer la clasificacion con SSC
% por ahora lo pongo en random

% p= floor(0.9*length(indices)); %seleccionamos el 50% de la data para in-sample 
% %pos es el vector de seleccion y se construye a partir de p
% pos = randperm(length(indices));
% pos = sort(pos(1:p));

p=length(indices1);
[a,b]=multi(p);
pos=sort(indices1);
Y=F(:,indices2);
souts=s(indices2);
F = F(:,pos);
sIns = s(pos);
% Xtemp(:,pos)=[];
% en Y quedan guardados los pixeles que son bordes y que vamos a clasificar
% usando los resultados de SSC
% Y=Xtemp;
% stemp(pos)=[];
% sOuts = stemp;
% clear Xtemp stemp;

% [IDX,C,SUMD,K]=kmeans_opt(F);
K=TSC(F,p);
% K=length(unique(s))-1;
%% S4C input parameters (Algoritmo de SSC modificado)
if (K>=1)
        
    log=1;

    alpha = 1000;
    %alpha = [1400,1000];
    r = 0; % data projection
    affine = true; % affine constraint
    outlier = false; % data has outlier
    rho = 0.7; 

    la = 7.76e-7; % sparsity/noise tradeoff
    alphass = 0.05 ;%[3.0 4.2] ;  % spectral/spatial tradeoff
    W=[];
    %% SCC Algorithm for In sample Data
    [Xmember,C] = SSC_S4C(F,r,affine,alpha,outlier,rho,sIns,K,la,alphass,a,b);

    %% Out-of-sample membership
    Ymember = OutSample(F,Y,Xmember);
    Ymember = Ymember';
%     missrate2 = sum(sOuts(find(sOuts))~=Ymember(find(sOuts)))/length(find(sOuts));

    %% Join Results
    grps= zeros(length(indices),1);
%     grps(pos)=Xmember;
%     pos2=1:length(indices);
%     pos2(pos)=[];
%     grps(pos2)=Ymember;
    grps()
        
else
    log=0;
    grps=s;
    
end

end