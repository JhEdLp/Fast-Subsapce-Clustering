function ARI = AdjustRI(mc)

% Input mc is the confusion matrix

sum_n=0;
D =diag(mc); 
for i=1:length(D)
    if D(i) >1
        sum_n = sum_n + nchoosek(D(i),2);
    end
end

sum_a = 0;
sum_b = 0;

for i=1 :length(mc)
    if sum(mc(i,:)) > 1
        sum_a = sum_a + nchoosek(sum(mc(i,:)), 2);
    end
    
    if sum(mc(:,i)) > 1
        sum_b = sum_b + nchoosek(sum(mc(:,i)), 2);
    end        
end

n = nchoosek(sum(mc(:)),2);

ARI = (sum_n-(sum_a*sum_b/n))/((sum_a+sum_b)/2 - (sum_a*sum_b/n));


end