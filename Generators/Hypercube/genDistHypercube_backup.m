function dist = genDistHypercube(l, d, base, modfunc, ntype)
%GENDISTHYPERCUBE Generates distance matrix for hypercube QAP instance
%   Detailed explanation goes here
    n = l^d;
    dist = zeros(n);
    coords = (dec2base(0:n-1,l) - '0') * base;
    for i = 1:n
        for j = [1:i-1,i+1:n]
            dist(i,j) = floor(modfunc(norm(coords(i,:) - coords(j,:),ntype)));
        end
    end
end

