% Copyright (c) 2024 by Yaokun Yang
% 
% The convergence rates of different Gaussian methods are compared
%
% 2024-12-12

clearvars
n1 = 3;
N = 40; % Count points
pointi = 51;
pointj = 35; % Point coordinates
index = 1; % 1.gx 2.gy 3.gz 4.uxx 5.uxy 6.uxz 7.uyy 8.uyz 9.uzz

%% model and area

model = [-50,50,-50,50,-150,-50,1000];
area = ObservationPlane(model);

x = area(1,:);
y = area(2,:);

%% Analytic solution processing

load("Data\Data\CuboidGravityByAnalytical.mat")
ana = a{index};
vana = ana(pointi,pointj)*ones(1,N-n1+1);

%% compute

G = 6.67408e-6;
Gp = G*model(7);

v = zeros(1,N-n1+1);
for n = n1:N
    [xi,yj,zk,W] = GaussLegendreCoef3(model,n*ones(1,3));
    v(n-n1+1) = Gp*GaussianQuad3(CuboidIntegrand_gx(x(pointj),y(pointi),0),xi,yj,zk,W);
end

figure(2)

n = n1:N;
plot(n,v,'LineWidth',1.3)
hold on
plot(n,vana,'LineWidth',1.3)
