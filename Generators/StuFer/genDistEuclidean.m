function [dist,xy,description] = genDistEuclidean(n,K,m,cc)
	% K: maximum size of each cluster
	% m: width of each cluster
	% cc: maximum value for cluster centre

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
			kk = randi(K);
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

    xstring = sprintf('%f,',xy(:,1));
    ystring = sprintf('%f,',xy(:,2));
    description = strcat("DistanceType,Euclidean\nMaximumCluster,",num2str(K,10),"\nClusterWidth,",num2str(m,10),"\nClusterCentreLoc,",num2str(cc), ...
        "\nXCoords,", extractBefore(xstring, length(xstring)), ...
        "\nYCoords,", extractBefore(ystring, length(ystring)), ...
        "\n");
end

