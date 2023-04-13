function distout = distmodfunc(distin)
%DISTMODFUNC Summary of this function goes here
%   Detailed explanation goes here

    distout = distin;
    if rand < 0.2
        distout = floor((1 + rand/2) * distin);
    end

end

