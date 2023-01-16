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
req1.name = "xtab%dN2";
req1.size = @(i) 50+(i-1)*5;
req1.count = 30;
req1.params = struct;
req1.params.M = 1000;
req1.params.tilt = 0;
%req1.params.A = -10;
req1.params.B = 5;

req2 = req1;
req2.name = "xtab%dT2";
req2.params.tilt = 0.1;

reqs = { req1, req2 };
        
for i = 1:length(reqs)
    req = reqs{i};
    for count = 1:req.count
        n = req.size(count);
        param = req.params;
        param.size = n;
        param.K = ceil(n/(rand*13+2));
        param.mu = rand*90+10;
        param.tilt = param.tilt * (rand * 2 + 1);
        param.A = rand*-15;
        dist = genDistTaiB(param);
        flow = genFlowTaiB(param);
        name = sprintf(req.name,n);
        qap_writeFile(strcat(outputDir,name,".dat"),dist,flow);
    end
end
