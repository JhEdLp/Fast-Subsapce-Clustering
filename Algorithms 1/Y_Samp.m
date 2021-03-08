function indices=Y_Samp(L,I)

U=unique(L);
% BW = boundarymask(L);
s = regionprops(L,'centroid');
centroids = floor(cat(1,s.Centroid));
% imagesc(L);
% hold on 
% plot(centroids(:,1),centroids(:,2),'r*')
% hold off
cop=I*0;
k1=7;%Número de filas
k2=7;%numero de columnas

k3=floor(k1/2);
k4=floor(k2/2);
for i=1:1:length(U)
    
    j=centroids(i,1);
    k=centroids(i,2);
    cop((j-k3):(j+k3),(k-k4):(k+k4))=I((j-k3):(j+k3),(k-k4):(k+k4));

end

% [X,Y]=find(cop~=0);
% figure,
% imagesc(L);
% hold on 
% plot(X,Y,'r*');
% plot(centroids(:,1),centroids(:,2),'y*');
% hold off
cop=reshape(cop,1,[])';
indices=find(cop~=0);
end
