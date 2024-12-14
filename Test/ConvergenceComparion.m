% Copyright (c) 2024 by Yaokun Yang
% 
% The convergence rates of different Gaussian methods are compared
%
% 2024-12-12

clearvars

format long

n1 = 3;
N = 75; % Count points
pointi = 51;
pointj = 31; % Point coordinates
index = 1; % 1.gx 2.gy 3.gz 4.uxx 5.uxy 6.uxz 7.uyy 8.uyz 9.uzz

%% model and area

model = [-50,50,-50,50,-150,-50,2000];
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

v1 = zeros(1,N-n1+1);
v2 = zeros(1,N-n1+1);
v3 = zeros(1,N-n1+1);
v4 = zeros(1,N-n1+1);
for n = n1:N
    [xi,yj,zk,W] = GaussLegendreCoef3(model,n*ones(1,3));
    v1(n-n1+1) = Gp*GaussianQuad3(CuboidIntegrand_gx(x(pointj),y(pointi),0),xi,yj,zk,W);
    [xi,yj,zk,W] = GaussChebyshevCoef3(model,n*ones(1,3));
    v2(n-n1+1) = Gp*GaussianQuad3(CuboidIntegrand_gx(x(pointj),y(pointi),0),xi,yj,zk,W);
    [xi,yj,zk,W] = RadauCoef3(model,n*ones(1,3));
    v3(n-n1+1) = Gp*GaussianQuad3(CuboidIntegrand_gx(x(pointj),y(pointi),0),xi,yj,zk,W);
    [xi,yj,zk,W] = LobattoCoef3(model,n*ones(1,3));
    v4(n-n1+1) = Gp*GaussianQuad3(CuboidIntegrand_gx(x(pointj),y(pointi),0),xi,yj,zk,W);
end

figure(2)
e1 = abs(v1 - vana);
e2 = abs(v2 - vana);
e3 = abs(v3 - vana);
e4 = abs(v4 - vana);

n = n1:N;
semilogy(n,e1,'LineWidth',1.3)
hold on
semilogy(n,e2,'LineWidth',1.3)
hold on
semilogy(n,e3,'LineWidth',1.3)
hold on
semilogy(n,e4,'LineWidth',1.3)
grid on
legend('Gauss-Legendre','Gauss-Chebyshev','Radau','Lobatto','Location','east')

xlabel('n')
ylabel('Error')
