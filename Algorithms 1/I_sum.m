function I=I_sum(IMG)

[M,N,L]=size(IMG);

I=zeros(M,N);
for i=1:L
    I=I+IMG(:,:,i);
end

end