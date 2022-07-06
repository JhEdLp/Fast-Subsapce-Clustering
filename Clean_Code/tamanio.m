function p=tamanio(m,n,t)

%funcion para tomar una parte entera de los datos con u incremeto del 0.05
%donde m y n son las dimensiones de la imagen espectral
p=0;
for i=n:-1:2
    
    if(m*i<t)
        
        p=i*m;
        break
        
    end
    
end
end


    