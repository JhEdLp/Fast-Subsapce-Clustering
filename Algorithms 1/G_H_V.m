function I=G_H_V(IMG,metodo)

GIh = zeros(size(IMG));
GIv = zeros(size(IMG));
[M,N,L]=size(IMG);
for i = 1:L
    GIh(:,:,i) = (edge(IMG(:,:,i),metodo,'horizontal'));
    GIv(:,:,i) = (edge(IMG(:,:,i),metodo,'vertical'));
end
GradIm = 0.5*(exp(-sum(GIh,3))+exp(-sum(GIv,3)));
GradIm = GradIm/max(max(GradIm));
I=GradIm;

end
