function dist = genDistTaiB(params)
%GENDIST Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 5
        tilt = 0;
    end

    size = params.size;
    M = params.M;
    K = params.K;
    mu = params.mu;
    tilt = params.tilt;
    
    points = zeros(size,2);
    count = 0;
    while count < size
        Theta = rand * 2 * pi;
        R = rand * M;
        N = randi(K);
        count2 = 0;
        while count2 < N
            phi = rand * 2 * pi;
            rho = rand * mu;
            count = count + 1;
            count2 = count2 + 1;
            points(count,1) = R*cos(Theta) + rho*cos(phi);
            points(count,2) = R*sin(Theta) + rho*sin(phi);
        end
    end
    
    % debug
    % scatter(points(:,1),points(:,2))
    
    dist = zeros(size);
    for i = 1:size
        for j = 1:size
            if (points(i,1) > points(j,1))
                dist(i,j) = ceil(sqrt(((1+tilt)*(points(i,1) - points(j,1)))^2 + (points(i,2) - points(j,2))^2));
            else
                dist(i,j) = ceil(sqrt(((1-tilt)*(points(i,1) - points(j,1)))^2 + (points(i,2) - points(j,2))^2));
            end
        end
    end
end

