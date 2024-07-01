function [flow] = genFlowDrexx(k,l)
%GENFLOWDREXX Summary of this function goes here
%   Detailed explanation goes here

n = k*l;
flow = -ones(n);

xy = -ones(n,2);
perm = randperm(n);

nextx = 0;
nexty = 0;

for i = 1:n
    xy(i,1) = nextx;
    xy(i,2) = nexty;
     
    nextx = nextx + 1;
    if nextx >= l
        nextx = 0;
        nexty = nexty + 1;
    end
end

for i = 1:n
    for j = 1:n
        d = norm(xy(i,:)-xy(j,:),1);
        if d == 0
            flow(i,j) = 0;
        elseif d == 1
            flow(i,j) = randi(10);
        else
            flow(i,j) = 0;
        end
    end
end

flow = flow(perm,perm);

end

