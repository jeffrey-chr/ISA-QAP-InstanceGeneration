function [dist,flow,optvalue,optperm] = generateInstance(n, nx, ny, h, w, rho_bound, m_lower, m_upper)
%GENERATEINSTANCE Summary of this function goes here
%   Detailed explanation goes here

    % Step 1
    flow = zeros(n);
    dist = zeros(n);

    b = zeros(n,2);
    proxy = zeros(n,1);
    for i = 1:n
        b(i,1) = randi(nx);
        b(i,2) = randi(ny);
        proxy(i) = b(i,1) + b(i,2) / (ny + 1);
    end

    mrange = m_lower:m_upper;
    mrange = mrange(rem(mrange,2) == 1);

    % Step 2
    for step = 1:h
        rho = 0; % 2.1
        m = mrange(randi(length(mrange))); % 2.2
        while rho < rho_bound
            choice = randperm(n,m); % 2.3
            [isgood, redblue] = bicoloring(b, choice); % 2.4
            if isgood
                alpha = randi(w); % 2.5
                Hm = zeros(n);
                for i = 1:length(choice)
                    for j = 1:length(choice)
                        if choice(i) < choice(j)
                            if redblue(i) == redblue(j)
                                Hm(choice(i),choice(j)) = -1;
                            else
                                Hm(choice(i),choice(j)) = 1;
                            end
                        end
                    end
                end
                flow = flow + Hm * alpha; 
                break
            else
                rho = rho + 1;
            end
        end
        if rho >= rho_bound
            save('failure.mat');
            error(-1);
        end
    end

    % Step 3
    [~, optperm] = sort(proxy,1,"ascend");
    for i = 1:n
        for j = 1:n
            dist(i,j) = norm(b(optperm(i),:) - b(optperm(j),:),1);
        end
    end

    % Step 4
    w_min = min(flow(:));
    optvalue = 0;
    if w_min < 0
        for i = 1:n
            for j = (i+1):n
                flow(i,j) = flow(i,j) - w_min;
            end
        end
        optvalue = -w_min * sum(dist,"all") / 2; 
    end

    

end

