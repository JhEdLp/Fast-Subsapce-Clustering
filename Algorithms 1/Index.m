function My_gt=Index(hyperimg,hyperimg_gt,aumento,Rho,Method)


[M,N,~] = size(hyperimg);
MN = M*N;
I = I_sum(hyperimg);

I = I - mean(I(:));
I = I./std(I(:));

[~, threshold] = edge(I,Method);
fudgeFactor = .4;
I = edge(I,Method, threshold * fudgeFactor);

[L,N1] = superpixels(I*1,aumento,'Compactness',10, 'Method', 'slic0');
BW = boundarymask(L);
My_gt = Segmentation(hyperimg,hyperimg_gt,L,N1,MN,BW,Rho);

end
