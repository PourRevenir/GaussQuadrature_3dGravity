% Copyright (c) 2024 by Yaokun Yang
% 
% The RRMS of different Gaussian methods 
%
% 2024-12-12

clearvars

N = 2:2:18;
%% 

model = [-50,50,-50,50,-150,-50,2000];
area = ObservationPlane(model);

A = CuboidGravity_analytical(model,area);

%% 

RRMS = zeros(length(N),9);
for i = N

V = CuboidGravity_GaussianQuad(model,area,'method','gl','n',i*ones(1,3));
E = ErrorCompare(V,A);

RRMS(i,:) = ErrorRRMS(E,A);
end

save("Data\Data\RRMSofGaussLegendre.mat",'RRMS','-mat')

%% 

RRMS = zeros(length(N),9);
for i = N

V = CuboidGravity_GaussianQuad(model,area,'method','gc','n',i*ones(1,3));
E = ErrorCompare(V,A);

RRMS(i,:) = ErrorRRMS(E,A);
end

save("Data\Data\RRMSofGaussChebyshev.mat",'RRMS','-mat')

%% 

RRMS = zeros(length(N),9);
for i = N

V = CuboidGravity_GaussianQuad(model,area,'method','r','n',i*ones(1,3));
E = ErrorCompare(V,A);

RRMS(i,:) = ErrorRRMS(E,A);
end

save("Data\Data\RRMSofRadau.mat",'RRMS','-mat')

%% 

RRMS = zeros(length(N),9);
for i = N

V = CuboidGravity_GaussianQuad(model,area,'method','l','n',i*ones(1,3));
E = ErrorCompare(V,A);

RRMS(i,:) = ErrorRRMS(E,A);
end

save("Data\Data\RRMSofLobatto.mat",'RRMS','-mat')
