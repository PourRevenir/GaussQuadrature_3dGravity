 % Copyright (c) 2024 by Central South University.                   
% coding: utf-8
% Test the time the function runs.                                                    
% Programme written by Y. Yang                            
% For more information, contact by email: <yangyaokun@csu.edu.cn>.  
% Please read the README.md before use.                             
%-------------------------------------------------------------------

clearvars

model = [-50,50,-50,50,-150,-50,2000];
area = ObservationPlane(model);
x = area(1,:);
y = area(2,:);

%% test the cost time
for k = 2:18
    n = k*ones(1,3);
    
    tic
    CuboidGravity_GaussianQuad(model,area,'method','l','n',n);
    toc
end

%% plot the cost time

load Data\CostTimeofGaussianQuad.mat

n = t(:,1);
t = t(:,2:5);

cv = mean(t,2);
pos = max(t,[],2) - cv;
neg = min(t,[],2) - cv;

figure
errorbar(n,cv,neg,pos,'-s','MarkerSize',5)
grid on
xlabel('Number of nodes')
ylabel('Cost time')
title('Computation time')
ax = gca;
ax.FontName = 'Times New Roman';
ax.FontSize = 14;