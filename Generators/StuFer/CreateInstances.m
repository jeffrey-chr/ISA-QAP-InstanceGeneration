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

recDims = [4, 10];
  
distGens  = {   @(n) genDistEuclidean(n,ceil(n/(rand*13+2)),rand*30+20,300), 'e'; % Random distances
                @(n) genDistManhattan(n,recDims(randi(2))), 'm';         % Grid distances
            };
        
flowGens  = {   @(n) genFlowRandom(n,rand*0.6+0.2,rand*6+1), 'r'; % Random flows
                @(n) genFlowStructured(n,rand*40+10,rand*6+1), 's'; % Structured flows
                @(n) genFlowStructuredPlus(n,rand*40+10,rand*6+1,0.05), 'p'; % Structured Plus flows
            };
        
for i = 1:length(instSizes)
    for j = 1:size(distGens,1)
        for k = 1:size(flowGens,1)
            for count = 1:5
                n = instSizes(i);
                dist = distGens{j,1}(n);
                flow = flowGens{k,1}(n);
                name = strcat('stf',num2str(n),distGens{j,2},flowGens{k,2},num2str(count));
                qap_writeFile(strcat(outputDir,name,".dat"),dist,flow);
            end
        end
    end
end
        