clear
clc
close all

rng(100);
%% Add paths

addpath('./Data/');
addpath('./Algoritmos/');
addpath('./Metrics/');
addpath('./lsc_matlab/')
addpath('./Clean_Code/')

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
Method = "Sobel"; % Method to use in edge detection. Also you can prove log,Canny, approxcanny and others;
Ns = 450; % Number of super pixels
Rho = 0.1; % Percentage of pixels to be projected
compactness = 10; % Compactness to use in super pixels matlab function
ac=fopen(n1,'w'); % File to save the clustering metrcis results
    


tic
My_gt = Index(hyperimg,hyperimg_gt,Ns,Rho,Method,compactness);    
result = evaluate_clustering_results(My_gt,hyperimg_gt(:));
tim=toc;
fprintf("Ns = %.0f Comp = %.2f  acc_o = %f acc_a = %f kappa = %f Fmeasure = %f NMI = %f time = %.4f\n", Ns,compactness,...
    result.acc_o,result.acc_a,result.kappa,result.Fmeasure,result.nmi,tim);
%             fprintf(ac,"Rho = %.2f OA = %f time = %f\n", Rho,result.acc_o, tim);
fprintf("\n--------------------------------------------------------------------\n");



if (~isempty(find(My_gt==1, 1)))
fprintf('\nPonits ungroup\n')
end

if (~isempty(find(My_gt==0, 1)))
fprintf('\nPonits ungroup\n')
end

    
    
        
