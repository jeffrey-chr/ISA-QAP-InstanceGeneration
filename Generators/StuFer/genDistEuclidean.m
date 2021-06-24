function [dist,xy] = genDistEuclidean(n,K,m,cc)
    kk = randi(K);
    
    xy = -ones(n,2);
    dist = -ones(n);
    
    numel = 0;
    
    cx = rand * cc;
    cy = rand * cc;
    numclust = 0;
    
    while (numel < n)
        if (numclust >= kk)
            cx = rand * cc;
            cy = rand * cc;
            numclust = 0;
        end
        
        numel = numel + 1;
        numclust = numclust + 1;
        xy(numel,1) = cx + rand*m - m/2;
        xy(numel,2) = cy + rand*m - m/2;
    end
    
    for i = 1:n
        for j = 1:n
            dist(i,j) = norm(xy(i,:)-xy(j,:));
        end
    end
    
    % Round the distances
    dist = round(dist);
end

