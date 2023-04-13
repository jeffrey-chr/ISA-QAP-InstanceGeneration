function flow = genFlowHypercube(l, d, base, modfunc)
%GENFLOWHYPERCUBE Generates distance matrix for hypercube QAP instance
%   Detailed explanation goes here
    n = l^d;
    flow = zeros(n);
    coords = (dec2base(0:n-1,l) - '0');
    for i = 1:n
        for j = [1:i-1,i+1:n]
            if abs(norm(coords(i,:) - coords(j,:),1) - 1) < 0.01
                flow(i,j) = modfunc(base);
            end 
        end
    end
end

