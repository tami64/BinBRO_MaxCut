% by Taymaz Akan / Saeid Agahian / Rahim Dehkharghani
%2021 BinBRO: Binary Battle Royale Optimizer Algorithm
% Expert system with application

clear, close all, clc
addpath('\..');
% mkdir('Results\cruves');
% addpath('Results\cruves');
mkdir('Results\CrosType_2\cruves');
mkdir('Results\CrosType_3\cruves');
mkdir('Results\CrosType_4\cruves');
CrossType = 2; % 1  2  3  4
fileIdAll = fopen(['Results\CrosType_',num2str(CrossType),'\all','.txt'],'w');
% fileIdAll = fopen(['Results\','all','.txt'],'w');
for i = 2:2
    [fsource , OptimumSol] = Get_Dataset(i);
    model = creat_model(fsource);
    Dim = model.NFacility;
    N = model.NFacility;
    maxiter = 1000;
    MaxFault = 4;
    NumRun = 25;
    thetama = 1;
    thetami = 0.1;
    [Res,cg_curve] = BRO_Fun(N,Dim,maxiter,MaxFault,CrossType,NumRun,model,thetama,thetami,OptimumSol);
    save(strcat('Results\CrosType_',num2str(CrossType),'\cruves\CR_',num2str(i),'.mat'),'cg_curve')
    save(strcat('Results\cruves\CR_',num2str(i),'.mat'),'cg_curve')
    Writ_on_text(strcat('F_',num2str(i)),Res,cg_curve,CrossType);
    Writ_on_text_all(Res,fileIdAll)
    
end
fclose(fileIdAll);
Res
