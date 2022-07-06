function [accuracy,porc,my_gt,vec_gt_Is,gt_Is,vec_gt_Os,gt_Os]=main(aumento,hyperimg,hyperimg_gt)
% clear all
% close all
% clc
%% Data path
% addpath('../Data/');
%% Select and load the database
% database = 'Indian_subset';%'Indian_subset'; %'Indian_subset_ori'; %'Salinas_corrected2'; 
% groundtruth = 'Ground_truth';%'Ground_truth_ori';%'Salinas_gt2'; 
% load(database);
% load(groundtruth);

% hyperimg = Indian_subset;
% hyperimg_gt = gt;


[M,N,L]=size(hyperimg);
s = hyperimg_gt(:);

F = reshape(hyperimg,[M*N,L])';

%% Normalization

F = F - mean(F(:));
F = F./std(F(:));

%% Seleccionar data fuera de los bordes

Xtemp = F;
stemp = s;

% aca p es un vector con posiciones o columnas que se van seleccionar
% entonces aca p debe contenter los indices que hacen referencia a los
% datos que vamos a usar para hacer la clasificacion con SSC
% por ahora lo pongo en random

% p= floor(0.1*N*M); %seleccionamos el 50% de la data para in-sample 
% %pos es el vector de seleccion y se construye a partir de p
% pos = randperm(M*N);
% pos = sort(pos(1:p));


pos=sort(Index(hyperimg,aumento));
p=tamanio(M,N,length(pos));
pos=pos(1:p);
p=length(pos);
porc=p/(M*N);

F = F(:,pos);
sIns = stemp(pos);
Xtemp(:,pos)=[];
%en Y quedan guardados los pixeles que son bordes y que vamos a clasificar
%usando los resultados de SSC
Y=Xtemp;
stemp(pos)=[];
sOuts = stemp;
clear Xtemp stemp;

%% S4C input parameters (Algoritmo de SSC modificado)

l = length(unique(s));% number of clusters que tienen los datos

alpha = 1000;
%alpha = [1400,1000];
r = 0; % data projection
affine = true; % affine constraint
outlier = false; % data has outlier
rho = 0.7; 

la = 7.76e-7; % sparsity/noise tradeoff
alphass = 0.05 ;%[3.0 4.2] ;  % spectral/spatial tradeoff
W=[];
tic
%% SCC Algorithm for In sample Data
[Xmember, missrate1,C] = SSC_S4C(F,r,affine,alpha,outlier,rho,sIns,l,la,alphass,M,p/M);

%% Separamos el gt en in-sample

vec_gt_Is=s(pos);
gt_Is=Xmember;

%% Out-of-sample membership
Ymember = OutSample(F,Y,Xmember);
Ymember = Ymember';
missrate2 = sum(sOuts(find(sOuts))~=Ymember(find(sOuts)))/length(find(sOuts));

%% Separamos el gt en out-sample

vec_gt_Os=s;
vec_gt_Os(pos)=[];
gt_Os=Ymember;

%% Join Results
grps= zeros(length(s),1);
grps(pos)=Xmember;
pos2=1:N*M;
pos2(pos)=[];
grps(pos2)=Ymember;

globalMissrate = sum(s(find(s))~=grps(find(s)))/length(find(s));

%% Draw the Results as in the paper
grps(grps==6)=0;
img=zeros(M*N,3);
img(find(grps==0),2)=1;%img(find(st==6),2)=1;
img(find(grps==2),1)=1;
img(find(grps==10),3)=1;
img(find(grps==11),1)=1;
img(find(grps==11),2)=1;
image(reshape(img,M,N,3))

% time=toc;
%figure,imagesc(double(hyperimg_gt))
accuracy=1-globalMissrate;
% purity=Purity(s,grps);
% nmi=NMI(s,grps);

my_gt=reshape(grps,M,N);
%fprintf("\nLa puridad del clustering es %f y el NMI es de %f \n\n\n",purity,nmi);
% fprintf("Accuracy %f  \n",1-globalMissrate);
end