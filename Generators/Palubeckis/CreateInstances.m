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
%             };

instSizes = 60:20:120;


        
for i = 1:length(instSizes)
    for count = 1:10
        n = instSizes(i);
        nx = 7;
        ny = 7;
        h = floor(n/2);
        w = 10;
        rho_bound = 50;
        m_lower = 3;
        m_upper = 19;
        [dist, flow, optvalue, optperm] = generatePaluInstance(n, nx, ny, h, w, rho_bound, m_lower, m_upper);
        name = strcat('xPalu',num2str(n),'_',num2str(count));
        qap_writeFile(strcat(outputDir,name,".dat"),dist,flow);
    end
end
        