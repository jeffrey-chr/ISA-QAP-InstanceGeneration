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

instSizes = {   50, '50', 1, 5;
                150, '150', 3, 10;
                300, '300', 6, 15;
            };
        
distGens  = {   @(n) genDistEuclidean(n,n/2,20,300), 'ra'; % Random distances, tight clustering
                @(n) genDistEuclidean(n,n/2,50,300), 'rb'; % Random distances, loose clustering
                @(n) genDistManhattan(n,n/25), 'ga';         % Grid distances, narrow grid
                @(n) genDistManhattan(n,n/10), 'gb';         % Grid distances, broad grid      
            };
        
flowGens  = {   @(n) genFlowRandom(n,rand*0.3+0.2,100,1), 'ra'; % Random flows, low sparcity 
                @(n) genFlowRandom(n,rand*0.3+0.5,100,1), 'rb'; % Random flows, high sparcity
                @(n) genFlowStructured(n,50,100,1), 'sa'; % Structured flows, low sparcity
                @(n) genFlowStructured(n,25,100,1), 'sb'; % Structured flows, high sparcity
                @(n) genFlowStructuredPlus(n,50,100,1,0.05), 'pa'; % Structured Plus flows, low sparcity
                @(n) genFlowStructuredPlus(n,25,100,1,0.05), 'pb'; % Structured Plus flows, high sparcity
            };
        
for i = 1:size(instSizes,1)
    for j = 1:size(distGens,1)
        for k = 1:size(flowGens,1)
            for count = 1:2
                n = instSizes{i,1};
                dist = distGens{j,1}(n);
                flow = flowGens{k,1}(n);
                name = strcat('stf',num2str(n),distGens{j,2},flowGens{k,2},num2str(count));
                qap_writeFile(strcat(outputDir,name,".dat"),dist,flow);
            end
        end
    end
end
        