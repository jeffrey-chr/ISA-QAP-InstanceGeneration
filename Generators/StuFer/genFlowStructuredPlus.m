function [flow, xy] = genFlowStructuredPlus(n,d,a,b,p)
%GENFLOWSTRUCTURED Summary of this function goes here
%   Detailed explanation goes here
flow = -ones(n);

% Generate a point in a square with side length 100 for each facility
% (These do NOT affect the distance matrix for the problem!)
xy = rand(n,2)*100;

for i = 1:n
    for j = 1:n
        if i == j 
			% No flow to 
            flow(i,j) = 0;
        else
            x = rand;
            if (norm(xy(i,:)-xy(j,:)) < d) || (x < p)
				% If distance between points is less than d, OR
				% with probability p, add flow (a*x)^b with 
				% x uniformly random in [0,1]
                x = rand;
                flow(i,j) = floor(max(1,ceil((a * x) ^ b)));
            else
				% Otherwise no flow between these facilities.
                flow(i,j) = 0;
            end
        end
    end
end

end

