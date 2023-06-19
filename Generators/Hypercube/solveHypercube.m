function [bestval, bestperm, solvals] = solveHypercube(D,F,dim,len)

% [D,F] = qap_readFile("..\Instances\ProblemData\tinytest\hyp8_1.dat");
% dim = 3;
% len = 2;
% [D,F] = qap_readFile("..\Instances\ProblemData\tinytest\hyp9_1.dat");
% dim = 2;
% len = 3;
% [D,F] = qap_readFile("..\Instances\ProblemData\Hypercube\hyp32_5.dat");
% dim = 5;
% len = 2;

n = size(D,1);
frmt = repmat('%d',1,dim);

%qap_solutionCostVec(D,F,1:n)
orderings = perms(1:dim);
solvals = -ones(2^dim*factorial(dim),1);
bestval = Inf;

for i = 1:(2^dim)
    for ord = 1:size(orderings,1)
        % choose the point to map to the origin
        posstr = dec2bin(i-1,dim);
        posorig = zeros(dim,1);
        for j = 1:dim
            posorig(j) = round(str2double(posstr(j))*(len-1));
        end
        
        perm = zeros(n,1);
        perm(1) = base2dec(sprintf(frmt,posorig),len) + 1;
    
        for k = 2:n
            posstr = dec2base(k-1,len,dim);
            pos = zeros(1,dim);
            for j = 1:dim
                pos(j) = round(str2double(posstr(j)));
            end
            
            pos = pos(orderings(ord,:));

            for j = 1:dim
                if posorig(j) > 0.5
                    pos(j) = (len-1) - pos(j);
                end
            end
    
            % convert back and add to permutation
            perm(k) = base2dec(sprintf(frmt,pos),len) + 1;
        end

        val = qap_solutionCostVec(D,F,perm);
        if (bestval > val)
            bestval = val;
            bestperm = perm;
        end
        solvals((i-1)*size(orderings,1) + ord) = val;
        %perm'

    end
    fprintf('%d of %d complete\n',i*size(orderings,1),2^dim*size(orderings,1))
end