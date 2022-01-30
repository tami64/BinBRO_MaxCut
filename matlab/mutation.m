function [X,Fit] = mutation(X,Fit,Eval,model)
Dim = length(X);

child =  X;
for i=1:3
    ind = randperm(Dim,2);
    temp = child(ind(1));
    child(ind(1)) = child(ind(2));
    child(ind(2)) = temp;
end
EvalTemp = Eval(model,child);
if (EvalTemp<Fit)
    X = child;
    Fit = EvalTemp;
end
end