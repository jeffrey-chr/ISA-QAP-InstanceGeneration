function flow = genFlowBroken(b, rd, symm)
%GENflow Summary of this function goes here
%   Detailed explanation goes here
    
    n = b(1);
    br = b(2);

    flow = zeros(n);
    
    widthx = floor(n/2);
    widthy = floor(n/2);
    
    for ii = 1:br
        for jj = ii:br
            xstart = 1 + ceil(widthx*(ii-1)/br);
            xend = 1 + ceil(widthx*ii/br) - 1;
            ystart = 1 + ceil(widthy*(jj-1)/br);
            yend = 1 + ceil(widthy*jj/br) - 1;
            
            if ii == jj
                for x = xstart:xend
                    for y = ystart:yend
                        if x > y
                            flow(x,y) = randi(20);
                            if symm
                                flow(y,x) = randi(20);
                            else
                                flow(y,x) = flow(x,y);
                            end
                        end
                    end
                end
            else
                fakeinf = 24 + randi(7);
                for x = xstart:xend
                    for y = ystart:yend
                        flow(x,y) = fakeinf;
                        flow(y,x) = fakeinf;
                    end
                end
            end
        end
    end
    
    widthx = n - floor(n/2);
    widthy = n - floor(n/2);
    
    for ii = 1:br
        for jj = 1:br
            xstart = n - widthx + 1 + ceil(widthx*(ii-1)/br);
            xend = n - widthx + 1 + ceil(widthx*ii/br) - 1;
            ystart = n - widthy + 1 + ceil(widthy*(jj-1)/br);
            yend = n - widthy + 1 + ceil(widthy*jj/br) - 1;
            
            if ii == jj
                for x = xstart:xend
                    for y = ystart:yend
						if x > y
							flow(x,y) = randi(20);
							if symm
								flow(y,x) = randi(20);
							else
								flow(y,x) = flow(x,y);
							end
						end
                    end
                end
            else
                fakeinf = 24 + randi(7);
                for x = xstart:xend
                    for y = ystart:yend
                        flow(x,y) = fakeinf;
                        flow(y,x) = fakeinf;
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
        flow(i,j) = randi(9);
        if symm
            flow(j,i) = flow(i,j);
        end
    end

end

