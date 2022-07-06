function T = Segmentation(hyperimg,hyperimg_gt,L,N1,MN,BW,rho)

[U,~]=build_Dmatrix(L,N1,MN,false,[]);
U=full(U);
[M,N,L]=size(hyperimg);
F = reshape(hyperimg,[M*N,L])';
T=zeros(M*N,1);
BW=BW(:)*1;

index_aux1=[];
index_aux2=[];
t=[];
g=[];
%parfor
parfor i=1:N1 % For parallel clutering, if you can run sequential clustering change to traditional for
    
    indices=find(U(i,:)==1);
    indices=sort(indices);
    aux1 = BW(indices); % The values of the mask are selected which belong to the segment i 
    aux2 = find(aux1==1);
    aux3 = find(aux1==0);
    bordes = indices(aux2); % Positions of the HSI which are edges in the segment i
    Nb = indices(aux3); % Positions of the HSI which aren't edges in the segment i
    
    if (length(Nb) <= 7)
        x = randperm(length(indices));
        a = floor(length(indices)/4);
        Nb = indices(x(1:a));
        bordes = indices(x(a+1:end));
    end

    [g1,g2,log]=SRSSSC(F,hyperimg_gt,bordes, Nb);
    
    if(log==1)
        
        t = [t indices];
        g = [g g1];  
        g = [g g2'];  
        
    elseif(log==0)
        
        index_aux2 = [index_aux2 indices];
        
    end
    
end

T(t)=g;

if (~isempty(index_aux2))
    clc
    Ftem = F;
    aux=[];
            
        uni = unique(T);
        uni(1) = [];
        for i=2:(length(uni)+1)            
            index = find(T==i)';           
            if(~isempty(index))
                x = randperm(length(index));
                x = x(1:floor(length(index)*rho));
                aux = [aux index(x)];  
            end
            
        end
        
        aux=sort(aux);
        F = F(:,aux);
        Ftem = Ftem(:,index_aux2);
        fprintf("\n\n\t The number of ungrouped points is  %.0f \n\n",length(index_aux2));
        fprintf("\n\n\t The number of points to be projected is %.0f \n\n",length(aux));
        T(index_aux2)=Copy_of_New_main(F,Ftem,T(aux));
        T = bestMapHS(T,hyperimg_gt)';
        
end
end