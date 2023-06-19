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

prefix = "hyp125_";
dim = 3;
len = 5;

for i = 1:20
    datafile = strcat("./output/",prefix,num2str(i),".dat");
    solfile = strcat("./slnoutput/",prefix,num2str(i),".sln");
    %solfile = 1;
    
    [D,F] = qap_readFile(datafile);
    [val, perm] = solveHypercube(D,F,dim,len);
    qap_writeSolution(solfile,val,perm)
end