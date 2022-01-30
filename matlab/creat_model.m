function [model] = creat_model(fsource)

fid = fopen(fsource);
tline = fgetl(fid);
newStr = split( tline );

NFacility = str2num(newStr{2});
Nclient = str2num(newStr{3});
f = zeros(NFacility,1);
%%
for i = 1:NFacility
    tline = fgetl(fid);
    newStr = split(tline);
    f(i) = str2num(newStr{3});
end
%%
demand = zeros(Nclient,1);
i =1;
temp = {};
cij = zeros(Nclient,NFacility);
while i<=Nclient+1
    tline = fgetl(fid);
    newStr = split(tline);
    Nvalue = size(newStr);
    withDot = strfind(newStr{2},'.');    
    if (Nvalue<4 & ~length(withDot))
        demand(i) = str2num(newStr{2});
        indx = find(cellfun(@isempty,temp));
        temp(indx) =[];
        if i>1
            cij(i-1,:) = cellfun(@str2num,temp);
        end
        i = i + 1;
        temp = {};
    else
        temp =  [temp ;newStr];
    end
    if (feof(fid))
        break
    end
end

indx = find(cellfun(@isempty,temp));
temp(indx) =[];
cij(Nclient,:) = cellfun(@str2num,temp);

model.NFacility = NFacility;
model.Nclient = Nclient;
model.fixedcost = f;
model.demand = demand;
model.cij = cij;

end



