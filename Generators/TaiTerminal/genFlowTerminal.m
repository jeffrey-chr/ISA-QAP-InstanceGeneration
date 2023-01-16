function flow = genFlowTerminal(b, rd, symm, base)
%GENDIST Summary of this function goes here
%   Detailed explanation goes here
    if length(b) == 1
        flow = zeros(b(1));
        for i = 1:size(flow,1)
            if ~symm
                flow(i,i) = randi(base);
            end
            for j = i+1:size(flow,2)
                flow(i,j) = randi(base);
                if symm
                    flow(j,i) = flow(i,j);
                else
                    flow(j,i) = randi(base);
                end
            end
        end
    else
        blocks = cell(b(end),1);
        for i = 1:b(end)
            blocks{i} = genFlowTerminal(b(1:end-1), rd, symm, base);
            blocks{i}(blocks{i}==0)=Inf;
        end
        flow = blocks{1};
        for i = 2:b(end)
            flow = blkdiag(flow,blocks{i});
        end
        mask = (flow == 0);
        flow(flow==Inf)=0;
        n = size(flow,1);
        rcount = rd(n) * (2 - symm);
        for r = 1:rcount
            i = 1;
            j = 1;
            while mask(i,j) == 0
                i = randi(n);
                j = randi(n);
            end
            flow(i,j) = max(flow(i,j) + randi(floor(base/4)),0);
            if symm
                flow(j,i) = flow(i,j);
            end
        end
    end
end

