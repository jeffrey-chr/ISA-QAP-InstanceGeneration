function dist = genDistTerminal(b, rd, symm, base, ip)
%GENDIST Summary of this function goes here
%   Detailed explanation goes here
    if length(b) == 1
        dist = zeros(b(1));
        for i = 1:size(dist,1)
            if ~symm
                dist(i,i) = randi(base);
            end
            for j = i+1:size(dist,2)
                dist(i,j) = randi(base);
                if symm
                    dist(j,i) = dist(i,j);
                else
                    dist(j,i) = randi(base);
                end
            end
        end
    else
        blocks = cell(b(end),1);
        for i = 1:b(end)
            blocks{i} = genDistTerminal(b(1:end-1), rd, symm, base, ip);
            blocks{i}(blocks{i}==0)=Inf;
        end
        dist = blocks{1};
        for i = 2:b(end)
            dist = blkdiag(dist,blocks{i});
        end
        mask = (dist == 0);
        for i = 1:size(dist,1)
            for j = i+1:size(dist,2)
                if mask(i,j)
                    dist(i,j) = ip(base, length(b)-1);
                    if symm
                        dist(j,i) = dist(i,j);
                    else
                        dist(j,i) = ip(base, length(b)-1);
                    end
                end
            end
        end
        dist(dist==Inf)=0;
        n = size(dist,1);
        rcount = rd(n) * (2 - symm);
        for r = 1:rcount
            i = 1;
            j = 1;
            while mask(i,j) == 0
                i = randi(n);
                j = randi(n);
            end
            dist(i,j) = max(dist(i,j) - randi(floor(base/2)),0);
            if symm
                dist(j,i) = dist(i,j);
            end
        end
    end
end

