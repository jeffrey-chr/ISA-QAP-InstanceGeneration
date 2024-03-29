%Generate new instances with distances based on vertices of hypercubes.

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

% instTypes = { %[5,3,3], 20, infproxy1, randdens1, true;
%               %[2,6], 20;
%               %[3,4], 20;
%               %[2,7], 10;
%               %[5,3], 10;
%               [2,5], 20;
%             };
instTypes = {
              [2,5], 8;
              [2,6], 8;
              [3,4], 8;
              [2,7], 8;
              [5,3], 8;
            };
        
for i = 1:size(instTypes,1)
    for count = 1:instTypes{i,2}
        dim = instTypes{i,1};
        l = dim(1);
        d = dim(2);
        n = l^d;
		%g = @(x) floor((1 + rand/2) * x);
		g = @(x) x + randi(x/2);
        dist = genDistHypercube(l, d, 20);
        flow = genFlowHypercube(l, d, 20, g);
        name = strcat('hyp',num2str(n),'_',num2str(count));
        qap_writeFile(strcat(outputDir,name,".dat"),dist,flow);

        description = strcat("InstanceType,Hypercube\nInstanceSize,",num2str(n), ...
            "\nSideLength,",num2str(l), ...
            "\nCubeDimension,",num2str(d), ...
            "\nBaseDistance,",num2str(20), ...
            "\nBaseFlow,",num2str(20), ...
            "\n");
        fid = fopen(strcat(descDir,name,".csv"),'w');
        fprintf(fid, description);
        fclose(fid);
    end
end
