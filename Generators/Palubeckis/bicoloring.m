function [isgood, orient] = bicoloring(b, choice)
%BICOLORING Summary of this function goes here
%   Detailed explanation goes here

    %BICOLORING

    % Step 1
    Vone = unique(b(choice,1));
    Vtwo = unique(b(choice,2));
    edges = b(choice,:);
    orient = zeros(length(edges),1);
    beta = zeros(length(Vone),1);
    mu1 = zeros(length(Vone),1);
    delta_in = zeros(length(Vone),1);
    delta_out = zeros(length(Vone),1);


    % Step 2
    flag = 0;
    for j = 1:length(Vtwo)
        relevant_edges = find(edges(:,2) == Vtwo(j));
        degree = length(relevant_edges);
        if rem(degree,2) == 0
            mu2 = 0;
        else
            if flag == 1
                mu2 = 1;
            else
                mu2 = -1;
            end
            flag = 1-flag;
        end
        s = (degree + mu2)/2;

        chooseS = randperm(degree,s);
        orient(relevant_edges) = -1;
        orient(relevant_edges(chooseS)) = 1;
    end
    
    % Step 3
    flag = 1;
    for i = 1:length(Vone)
        relevant_edges = find(edges(:,1) == Vone(i));
        degree = length(relevant_edges);
        delta_in(i) = sum(orient(relevant_edges) == -1);
        delta_out(i) = sum(orient(relevant_edges) == 1);
        Delta_x = delta_in(i) - delta_out(i);
        if rem(degree,2) == 0
            mu1(i) = 0;
        else
            if flag == 1
                mu1(i) = 1;
            else
                mu1(i) = -1;
            end
            flag = 1-flag;
        end
        beta(i) = Delta_x - mu1(i);
    end

    %BALANCE

    negset = find(beta < 0);
    posset = find(beta > 0);
    while ~isempty(negset)

        % find a path
        paths = cell(length(Vone), 1);
        vone_seen = zeros(length(Vone), 1);
        vtwo_seen = zeros(length(Vtwo), 1);
        queue = negset(1);
        paths{negset(1)} = [];
        vone_seen(negset(1)) = 1;
        goodpath = [];
        
        while length(queue) > 0
            start = queue(1);
            queue = queue(2:end);
            % find candidate links
            outlinks = find(edges(:,1) == Vone(start) & orient == 1);
            for lout = 1:length(outlinks)
                dest = edges(outlinks(lout),2);
                dest_v = find(Vtwo == dest);
                if vtwo_seen(dest_v) == 0
                    vtwo_seen(dest_v) = 1;
                    backlinks = find(edges(:,2) == dest & orient == -1);
                    for lback = 1:length(backlinks)
                        back = edges(backlinks(lback),1);
                        back_v = find(Vone == back);
                        if vone_seen(back_v) == 0
                            vone_seen(back_v) = 1;
                            queue = [queue, back_v]; %#ok<AGROW> 
                            paths{back_v} = [paths{start}, outlinks(lout), backlinks(lback)];
                            if any(back_v == posset)
                                goodpath = paths{back_v};
                                break
                            end
                        end
                    end
                    if ~isempty(goodpath)
                        break
                    end
                end
            end
            if ~isempty(goodpath)
                break
            end
        end
        
        if isempty(goodpath)
            isgood = false;
            return
        end

        % change orientation of arcs
        orient(goodpath) = orient(goodpath) * -1;

        % Re-calculate beta
        for i = 1:length(Vone)
            relevant_edges = find(edges(:,1) == Vone(i));
            delta_in(i) = sum(orient(relevant_edges) == -1);
            delta_out(i) = sum(orient(relevant_edges) == 1);
            Delta_x = delta_in(i) - delta_out(i);
            beta(i) = Delta_x - mu1(i);
        end

        negset = find(beta < 0);
        posset = find(beta > 0);
    end

    isgood = true;

end

