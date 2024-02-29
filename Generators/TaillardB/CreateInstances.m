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
descDir = ".\description\";

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

repeats = 2;

req1 = struct;
req1.name = "xtab%dN%d";
req1.size = @(i) 30+(ceil(i/repeats)-1)*5;
req1.id = @(i) rem(i-1,repeats)+1;
req1.count = 20*repeats;
req1.params = struct;
req1.params.M = 1000;
req1.params.tilt = 0;
%req1.params.A = -10;
req1.params.B = 5;

req2 = req1;
req2.name = "xtab%dT%d";
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
        name = sprintf(req.name,n,req.id(count));
        qap_writeFile(strcat(outputDir,name,".dat"),dist,flow);

        description = strcat("InstanceType,TaiBGenerator\nInstanceSize,",num2str(n), ...
            "\nOverallRadius,",num2str(param.M,10), ...
            "\nMaximumCluster,",num2str(param.K,10), ...
            "\nClusterRadius,",num2str(param.mu,10), ...
            "\nTilt,",num2str(param.tilt,10), ...
            "\nFlowBParam,", num2str(param.B,10), ...
            "\nFlowAParam,", num2str(param.A,10), ...
            "\n");
        fid = fopen(strcat(descDir,name,".csv"),'w');
        fprintf(fid, description);
        fclose(fid);
    end
end
