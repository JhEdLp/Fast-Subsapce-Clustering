function purity = Purity(CM)

% The input es the confusion matrix

purity = 0;

for i=1: length(CM)
    purity = purity + max(CM(i, :));
end
 purity = purity/sum(CM(:));

end