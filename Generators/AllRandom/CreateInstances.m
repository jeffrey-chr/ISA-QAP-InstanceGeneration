if ~exist('qap_writeFile','file')
    ufid = fopen('..\..\linkdir.txt','r');
    uline = fgetl(ufid);
    fclose(ufid);
    oldpath = path;
    path(oldpath,uline);
end

if ~exist('qap_writeFile','file')
    error('Failed to load utilities');
end

outputDir = ".\output\";

% instSizes = {   50, '50', 1, 5;
%                 100, '100', 2, 10;
%                 150, '150', 3, 10;
%                 200, '200', 4, 10;
%                 300, '300', 6, 15;
%                 500, '500', 10, 20; 
%  };

infproxy1 = @(base, n) base * 2 * n + randi(floor(base)/2);
%infproxy1 = @(base, n) base * 4 + randi(floor(base)/2);
randdens1 = @(n) floor(randi(n) + n/2);

req1 = struct;
req1.name = "xran%dS1";
req1.size = @(i) 50+(i-1)*5;
req1.count = 30;
req1.params = struct;
req1.params.symm = true;

req2 = req1;
req2.name = "xran%dA1";
req2.params.symm = false;

reqs = { req1, req2 };
        
for i = 1:length(reqs)
    req = reqs{i};
    for count = 1:req.count
        n = req.size(count);
        param = req.params;
        dist = floor(rand(n)*1000);
        flow = floor(rand(n)*1000);
        for jj = 1:n
            dist(jj,jj) = 0;
            flow(jj,jj) = 0;
            if param.symm
                for kk = jj+1:n
                    dist(jj,kk) = dist(kk,jj);
                    flow(jj,kk) = flow(kk,jj);
                end
            end
        end
        name = sprintf(req.name,n);
        qap_writeFile(strcat(outputDir,name,".dat"),dist,flow);
    end
end
