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

%infproxy1 = @(base, n) base * 4 + randi(floor(base)/2);
randdens1 = @(n) floor(randi(n) + n/2);

instTypes = { [45,3], 20, randdens1, true;
              [75,3], 20, randdens1, true;
              [125,5], 20, randdens1, true;
              [175,5], 20, randdens1, true;
            };
        
for i = 1:size(instTypes,1)
    for count = 1:instTypes{i,2}
        b = instTypes{i,1};
        rd = instTypes{i,3};
        symm = instTypes{i,4};
        n = b(1);
        dist = genDistBroken(b, rd, symm);
        flow = genFlowBroken(b, rd, symm);
        name = strcat('xtai',num2str(n),'e',num2str(count));
        qap_writeFile(strcat(outputDir,name,".dat"),dist,flow);
    end
end
