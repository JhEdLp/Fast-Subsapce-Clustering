load('../Resultados/Parallel/cmp.mat');
a = find(hyperimg_gt==1);
My_gt(a)=1;
a = reshape(My_gt,M,N);
imagesc(a), colormap(cmp)

a = readtable('../Resultados/Parallel/PaviaU/Results.txt');
x = a.Var3;
y = a.Var9;
plot(x,y, '-r')
hold on
a = readtable('../Resultados/Parallel/PaviaU/Results_1.txt');
x = a.Var3;
y = a.Var9;
plot(x,y, '-b')
a = readtable('../Resultados/Parallel/PaviaU/Results_2.txt');
x = a.Var3;
y = a.Var9;
plot(x,y, '-M')
a = readtable('../Resultados/Parallel/PaviaU/Results_3.txt');
x = a.Var3;
y = a.Var9;
plot(x,y, '-g')

