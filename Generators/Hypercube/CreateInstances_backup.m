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

f = @(x) distmodfunc(x);
g = @(x) floor((1 + rand/2) * x);

instTypes = { %[5,3,3], 20, infproxy1, randdens1, true;
              [2,6], 20, f, 1, g;
              [3,4], 20, f, 1, g;
            };
        
for i = 1:size(instTypes,1)
    for count = 1:instTypes{i,2}
        dim = instTypes{i,1};
        l = dim(1);
        d = dim(2);
        n = l^d;
        modfunc = instTypes{i,3};
        ntype = instTypes{i,4};
        g = instTypes{i,5};
        if ntype == 1
            nname = 'm';
        else
            nname = 'e';
        end
        dist = genDistHypercube(l, d, 100, modfunc, ntype);
        flow = genFlowHypercube(l, d, 100, g);
        name = strcat('hyp',num2str(n),nname,num2str(count));
        qap_writeFile(strcat(outputDir,name,".dat"),dist,flow);
    end
end
