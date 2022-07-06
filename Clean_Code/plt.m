clc
close all
load('/home/jhonlopez/Clustering/Code-SRSSSC/Resultados/Parallel/cmp.mat')
a = find(hyperimg_gt(:)==0)';
g(a)=1;
imagesc(reshape(g,610,340)), colormap(cmp)