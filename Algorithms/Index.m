function My_gt=Index(hyperimg,hyperimg_gt,aumento,Rho,Method, compactness)

[M,N,L] = size(hyperimg);
MN = M*N;
I = I_sum(hyperimg);
%I=I_RGB(hyperimg(:,:,1:198));
%I=G_H_V(hyperimg,'sobel');
% F = reshape(hyperimg,[M*N,L])';
% I = hyperPct(F, 1);
% I = reshape(I, [M,N,1]);
% I = rgb2gray(I);

I = I - mean(I(:));
I = I./std(I(:));

[~, threshold] = edge(I,Method);
fudgeFactor = .4;
I = edge(I,Method, threshold * fudgeFactor);
%% For LSC super pixels algotirmh
% ratio=0.075;
% rgbImage = uint8(cat(3, I*1, I*1, I*1));
% L = LSC_mex(rgbImage, aumento, ratio);
% N1 = aumento;

%% For popossal algoritm
[L,N1] = superpixels(I*1,aumento,'Compactness',compactness, 'Method', 'slic0');
% L = kmeans(I(:), aumento, 'MaxIter', 500, 'Start', 'uniform');
% L = reshape(L, M, N);
% N1 = aumento;
BW = boundarymask(L);
My_gt = Segmentation(hyperimg,hyperimg_gt,L,N1,MN,BW,Rho);

end
