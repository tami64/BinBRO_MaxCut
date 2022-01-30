clear, close all, clc
addpath('\..');
benchmark = 2;
[fsource , OptimumSol] = Get_Dataset(benchmark);
model = creat_model(fsource);
Dim = model.NFacility;
N = model.NFacility;
maxiter = 1000;
MaxFault = 4;
CrossType = 4; % 1: (original Paper)
NumRun = 5;
thetama = 1;
thetami = 0.1;

[Res,cg_curve] = BRO_Fun(N,Dim,maxiter,MaxFault,CrossType,NumRun,model,thetama,thetami,OptimumSol);
disp(Res);
plot(cg_curve)
% Eval = @uflp;
% sol = zeros(65535,1);
% for i = 1:65535
%     a = dec2bin2(i);
% 
%     if length(a)~=16
%         k = 16-length(a);
%         a=[zeros(1,k),a];
%     end
%     sol(i) = Eval(model,a);
% end
% m = min(sol)
% 932616



