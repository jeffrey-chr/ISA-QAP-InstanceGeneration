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

instTypes = { %[5,3,3], 20, infproxy1, randdens1, true;
              [5,5,3], 20, infproxy1, randdens1, true;
              [5,5,5], 20, infproxy1, randdens1, true;
              [7,5,5], 20, infproxy1, randdens1, true;
              [3,5,7], 20, infproxy1, randdens1, true;
            };
        
for i = 1:size(instTypes,1)
    for count = 1:instTypes{i,2}
        b = instTypes{i,1};
        ip = instTypes{i,3};
        rd = instTypes{i,4};
        symm = instTypes{i,5};
        n = 1;
        for j = 1:length(b)
            n = n * b(j);
        end
        dist = genDistTerminal(b, rd, symm, 20, ip);
        flow = genFlowTerminal(b, rd, symm, 20);
        name = strcat('term',num2str(n),'_',num2str(count));
        qap_writeFile(strcat(outputDir,name,".dat"),dist,flow);
    end
end
