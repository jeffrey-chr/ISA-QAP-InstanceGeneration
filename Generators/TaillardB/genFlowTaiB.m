function flow = genFlowTaiB(params)
%GENDIST Summary of this function goes here
%   Detailed explanation goes here

    size = params.size;
    A = params.A;
    B = params.B;

    flow = zeros(size);
    for i = 1:size
        for j = i+1:size
            flow(i,j) = floor(10^((B-A)*rand + A));
            flow(j,i) = floor(10^((B-A)*rand + A));
        end
    end

end

