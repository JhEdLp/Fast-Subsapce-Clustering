function I=I_RGB(IMG)

IMG=IMG(:,:,1:102);
[M,N,L]=size(IMG);
L2=3;

% %% Building RGB Image
DRGB=kron(speye(L2),sparse(kron(ones(1,L/L2),speye(M*N))));   % RGB Sampling
Frgb=DRGB*IMG(:); %Side information
I=reshape(Frgb,M,N,L2);

k = [0.2989 0.5871 0.1140];
I = I(:,:,1)*k(1) + I(:,:,2)*k(2) + I(:,:,3)*k(3);
end
