function [cost] = uflp(model,x)
global NFE;
NFE = NFE + 1;
%CAPACITY_ Summary of this function goes here
%   Detailed explanation goes here
if(sum(x)==0)
   cost = inf;
   return;
end
I = 1:model.NFacility;
I(x==0) = [];
fixi = sum(model.fixedcost(I));
cyij = 0;
for j = 1:model.Nclient
        cyij = cyij + min(model.cij(j,I));
end
cost = cyij + fixi;
end

