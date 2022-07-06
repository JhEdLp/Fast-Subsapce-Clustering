clear
clc
close all

rng(100);
%% Add paths

addpath('../Data/');
addpath('../Algoritmos/');
addpath('../Metricas/');
addpath('../lsc_matlab/')

dataset = 'Indian';
% dataset = 'Salinas';
% dataset = 'PaviaU';

if strcmp(dataset,'Indian')
        
    load Indian_pines_corrected.mat
    load Indian_pines_gt.mat
    hyperimg=indian_pines_corrected;
    hyperimg_gt=indian_pines_gt;
    n1 = strcat('../Resultados/Parallel/Indian Pines/New_superpixel.txt');
    fprintf('\n------ Loaded dataset Indian Pines ----------\n');
    
elseif strcmp(dataset, 'Salinas')
    
    load Salinas.mat
    hyperimg=salinas_corrected;
    hyperimg_gt=salinas_gt;
    n1 = strcat('../Resultados/Parallel/Salinas/New_superpixel.txt');
    fprintf('\n------ Loaded dataset Salinas ----------\n');
    
elseif strcmp(dataset, 'PaviaU')
    
    load paviaU.mat
    hyperimg=paviaU;
    hyperimg_gt=paviaU_gt;
    n1 = strcat('../Resultados/Parallel/PaviaU/New_superpixel.txt');
    fprintf('\n------ Loaded dataset Pavia University ----------\n');
    
else
    
    fprintf('\n------ Dataset not found ----------\n');
    quit;
end

%% Execute

[M,N,L] = size(hyperimg);
F = reshape(hyperimg,[M*N,L]);
hyperimg_gt = fix_labels(hyperimg_gt(:));
Method = ["Sobel","log","Canny", "approxcanny"];
% Ns = Points(M,N,50,5000,500);
Ns = 50:50:5000;
ac=fopen(n1,'w');
    
for Rho=0.01
    for m = Method(1)    
    for j = Ns
        for i=10

            tic
            My_gt = Index(hyperimg,hyperimg_gt,j,Rho,m,i);    
            result = evaluate_clustering_results(My_gt,hyperimg_gt(:));
            tim=toc;
            fprintf(ac,"Ns = %.0f Comp = %.2f  acc_o = %f acc_a = %f kappa = %f Fmeasure = %f NMI = %f time = %.4f\n",j,i,result.acc_o,result.acc_a,result.kappa,result.Fmeasure,result.nmi,tim);
%             fprintf(ac,"Rho = %.2f OA = %f time = %f\n", Rho,result.acc_o, tim);
            fprintf("\n--------------------------------------------------------------------\n");

        end 
        
        if (length(find(My_gt==1)) ~= 0)
            fprintf('\nPonits ungroup\n')
        end
        
        if (length(find(My_gt==0)) ~= 0)
            fprintf('\nPonits ungroup\n')
        end
    end
    
    
        
    end
end
