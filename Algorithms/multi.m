function [n1,n2]=multi(n)

z = [ ] ;
n1=n;
n2=1;

for i = 2:n-1 
    m = mod(n , i) ;
    if m == 0
        z = [z i] ;
    end
end

z = z';

if (~isempty(z))
    
    if(mod(length(z),2)==0)
        
        n1=z(ceil(length(z)/2));
        n2=z(floor(length(z)/2)+1);
        
    else
        
        n1=z(ceil(length(z)/2));
        n2=n1;
        
    end        
    
end

end