function indices=Not_Samp(L)

BW = boundarymask(L);
Vectorizada=reshape(BW,1,[]);
indices=find(Vectorizada==0);%pixeles negros

end
