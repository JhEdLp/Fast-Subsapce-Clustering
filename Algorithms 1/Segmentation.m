function T = Segmentation(hyperimg,hyperimg_gt,L,N1,MN,BW,rho)

[U,~]=build_Dmatrix(L,N1,MN,false,[]);
U=full(U);
[M,N,L]=size(hyperimg);
F = reshape(hyperimg,[M*N,L])';
T=zeros(M*N,1);
BW=BW(:)*1;

index_aux2=[];
t=[];
g=[];
%parfor
parfor i=1:N1
    
    indices=find(U(i,:)==1);
    indices=sort(indices);
    aux1 = BW(indices);%%Se seleccionan los valores de la mascara los cuales pertenecen al segmento i 
    aux2 = find(aux1==1);
    aux3 = find(aux1==0);
    bordes = indices(aux2);%Indices de la HSI los cuales son bordes en el segmento i
    Nb = indices(aux3);%Indices de la HSI los cuales no son bordes en el segmento i
    
%     if (length(Nb) <= 1)
%         x = randperm(length(indices));
%         a = floor(length(indices)/4);
%         Nb = indices(x(1:a));
%         bordes = indices(x(a+1:end));
%     end

    [g1,g2,log]=F4SC(F,hyperimg_gt,bordes, Nb);
    
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
        fprintf("\n\n\t La cantidad de puntos no agrupados es   %.0f \n\n",length(index_aux2));
        fprintf("\n\n\t La cantidad de puntos a los que se  proyectará es   %.0f \n\n",length(aux));
        T(index_aux2)=Copy_of_New_main(F,Ftem,T(aux));
        T = bestMapHS(T,hyperimg_gt)';
        
end
end