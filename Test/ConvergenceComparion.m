% Copyright (c) 2024 by Yaokun Yang
% 
% The convergence rates of different Gaussian methods are compared
%
% 2024-12-12

clearvars

N = 35; % Count points
pointi = 51;
pointj = 30; % Point coordinates
index = 1; % 1.gx 2.gy 3.gz 4.uxx 5.uxy 6.uxz 7.uyy 8.uyz 9.uzz

%% model and area

model = [-50,50,-50,50,-150,-50,1000];
area = ObservationPlane(model);

x = area(1,:);
y = area(2,:);

%% Analytic solution processing

load("Data\Data\CuboidGravityByAnalytical.mat")
ana = a{index};
vana = ana(pointi,pointj)*ones(1,N);

%% compute

G = 6.67408e-6;
Gp = G*model(7);

v = zeros(1,N-4);
for n = 5:N
    [xi,yj,zk,W] = GaussLobattoCoef3(model,n*ones(1,3));
    v(n) = Gp*GaussianQuad3(CuboidIntegrand_gx(x(pointj),y(pointi),0),xi,yj,zk,W);
end

plot(v)
