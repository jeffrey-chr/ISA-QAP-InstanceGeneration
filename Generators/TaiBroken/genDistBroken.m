function dist = genDistBroken(b, rd, symm)
%GENDIST Summary of this function goes here
%   Detailed explanation goes here
    n = b(1);
    br = b(2);

    dist = zeros(n);
    
    widthx = n - floor(n/2);
    widthy = floor(n/2);
    
    for ii = 1:br
        for jj = 1:br
            xstart = n - widthx + 1 + ceil(widthx*(ii-1)/br);
            xend = n - widthx + 1 + ceil(widthx*ii/br) - 1;
            ystart = 1 + ceil(widthy*(jj-1)/br);
            yend = 1 + ceil(widthy*jj/br) - 1;
            
            if ii + jj == br + 1
                for x = xstart:xend
                    for y = ystart:yend
                        dist(x,y) = randi(20);
                        if symm
                            dist(y,x) = randi(20);
                        else
                            dist(y,x) = dist(x,y);
                        end
                    end
                end
            else
                fakeinf = 24 + randi(7);
                for x = xstart:xend
                    for y = ystart:yend
                        dist(x,y) = fakeinf;
                        dist(y,x) = fakeinf;
                    end
                end
            end
        end
    end
    
    rcount = rd(n) * (2 - symm);
    for r = 1:rcount
        i = 1;
        j = 1;
        while i == j
            i = randi(n);
            j = randi(n);
        end
        dist(i,j) = randi(9);
        if symm
            dist(j,i) = dist(i,j);
        end
    end

end

