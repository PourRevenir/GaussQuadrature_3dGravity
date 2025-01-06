% Copyright (c) 2024 by Central South University.                   
% coding: utf-8
% Calculate relative root-mean-square error.                                                     
% Programme written by Y. Yang                            
% For more information, contact by email: <yangyaokun@csu.edu.cn>.  
% Please read the README.md before use.                             
%-------------------------------------------------------------------

clearvars

N = 2:2:18;

model = [-50,50,-50,50,-150,-50,2000];
area = ObservationPlane(model);

A = CuboidGravity_analytical(model,area);

%% RRMS of Gauss-Legendre quadrature

RRMS = zeros(length(N),9);
for i = N

V = CuboidGravity_GaussianQuad(model,area,'method','gl','n',i*ones(1,3));
E = ErrorCompare(V,A);

RRMS(i,:) = ErrorRRMS(E,A);
end

save("Data\RRMSofGaussLegendre.mat",'RRMS','-mat')

%% RRMS of Gauss-Chebyshev quadrature

RRMS = zeros(length(N),9);
for i = N

V = CuboidGravity_GaussianQuad(model,area,'method','gc','n',i*ones(1,3));
E = ErrorCompare(V,A);

RRMS(i,:) = ErrorRRMS(E,A);
end

save("Data\RRMSofGaussChebyshev.mat",'RRMS','-mat')

%% RRMS of Radau quadrature

RRMS = zeros(length(N),9);
for i = N

V = CuboidGravity_GaussianQuad(model,area,'method','r','n',i*ones(1,3));
E = ErrorCompare(V,A);

RRMS(i,:) = ErrorRRMS(E,A);
end

save("Data\RRMSofRadau.mat",'RRMS','-mat')

%% RRMS of Lobatto quadrature

RRMS = zeros(length(N),9);
for i = N

V = CuboidGravity_GaussianQuad(model,area,'method','l','n',i*ones(1,3));
E = ErrorCompare(V,A);

RRMS(i,:) = ErrorRRMS(E,A);
end

save("Data\RRMSofLobatto.mat",'RRMS','-mat')
