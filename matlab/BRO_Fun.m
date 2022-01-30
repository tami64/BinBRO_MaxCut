function [Res,cg_curve1] = BRO_Fun(N,Dim,maxiter,MaxFault,CrossType,NumRun,model,thetama,thetami,OptimumSol)
global NFE;
Res = [];
tic
cg_curve1 = zeros(1,maxiter);
Hit = 0;
Gap = 0;
EVL = [];
ListNFE = [];
for R = 1:NumRun
    NFE = 0;
    disp(['Run: ' num2str(R) ' Start' ])
    Shrink = ceil(log10(maxiter));
    Step = round(maxiter/Shrink);
    %%
    soldier.xy = [];
    soldier.Fit = [];
    soldier.Fault  = zeros(1,N);
    flag.Fit = inf;
    soldier.xy = [];
    Eval = @uflp;
    %     ShrinkMinMax = XMinMax;
    
    %% Initialization
    soldier.xy = randi([0 1],N,Dim);
    for i=1:N
        soldier.Fit(i) = Eval(model,soldier.xy(i,:));
    end
    
    flag.xy = [];
    flag.Fit = 0;
    
    [flag.Fit,indx] = min(soldier.Fit);
    flag.xy = soldier.xy(indx,:);
    
    %%
    STDdim = zeros(Dim,1);
    cg_curve = zeros(1,maxiter)+OptimumSol;
    for iter = 1:maxiter
        %         theta = thetama-((thetama-thetami)/maxiter)*iter;
        theta = Dim-((Dim-1)/maxiter)*iter;
        a = theta/Dim;
        cg_curve(iter) = flag.Fit;
        for i = 1:N
            [~,Cn] =  Dsimilarity(soldier.xy(i,:),soldier.xy,i);
            dam = i;
            Vic = Cn;
            if (soldier.Fit(Cn) > soldier.Fit(i))
                dam = Cn;
                Vic = i;
            end
            soldier.Fault(dam)= soldier.Fault(dam) + 1;
            soldier.Fault(Vic) = 0;
            if (soldier.Fault(dam) < MaxFault)
                [soldier.xy(dam,:) soldier.Fit(dam)]= MyCrossOverFcn(soldier.xy(dam,:),flag.xy,Dim,CrossType,Eval,model);
            else
                b = randperm(Dim,ceil(a*Dim));
                soldier.xy(dam,b) = randi([0 1],1,numel(b));
                soldier.Fault(dam) = 0;
                soldier.Fit(dam) = Eval(model,soldier.xy(dam,:));
            end
                                
            [soldier.xy(Vic,:),soldier.Fit(Vic)] = mutation(soldier.xy(Vic,:),soldier.Fit(Vic),Eval,model);
            
            [flag.xy,flag.Fit] = mutation(flag.xy,flag.Fit,Eval,model);

            if(soldier.Fit(dam)<flag.Fit)
                flag.Fit = soldier.Fit(dam);
                flag.xy = soldier.xy(dam,:);
            end
            if(soldier.Fit(Vic)<flag.Fit)
                flag.Fit = soldier.Fit(Vic);
                flag.xy = soldier.xy(Vic,:);
            end
        end       
        Er = flag.Fit-OptimumSol;
        if  Er<=0.009
            Hit = Hit + 1;
            EVL =  [EVL,iter];
            break;
        end
            
    end
    ListNFE(R) = NFE;
    
    Gap(R) = ((flag.Fit - OptimumSol)/OptimumSol)*100;
    Res.fit(R) = flag.Fit;
    cg_curve1 = cg_curve1 + cg_curve;          
end
Gap = mean(Gap);
cg_curve1 = cg_curve1/NumRun;
MeanTim = toc/NumRun;
MeanBest = mean(Res.fit);
Best = min(Res.fit);
Worst = max(Res.fit);
StdBest = std(Res.fit);

Res.cg_curve = cg_curve;
Res.MeanTim =  MeanTim;
Res.MeanBest = MeanBest;
Res.Best = Best;
Res.Worst = Worst;
Res.StdBest = StdBest;
Res.Hit = Hit/NumRun;
Res.Gap = Gap;
Res.Evl = mean(EVL);
Res.NFE = mean(ListNFE);
Res.Dim = Dim;

end
