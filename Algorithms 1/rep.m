function z = rep(a)
[m, n] =  size(a);
m = mean(a,1);
r = sort(m);
z = [find(m == r(1)) find(m == r(floor(n/2))) find(m == r(end))];
end