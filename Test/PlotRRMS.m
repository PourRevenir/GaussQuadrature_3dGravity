% Copyright (c) 2024 by Central South University.
% coding: utf-8
% Plot the figure in the paper.
% Programme written by Y. Yang
% For more information, contact by email: <yangyaokun@csu.edu.cn>.
% Please read the README.md before use.
%-------------------------------------------------------------------

clearvars

n = 2:18;

%% load data

load Data\RRMSofIntegral3.mat
RRMSofIntegral3 = RRMS;

load Data\RRMSofGaussChebyshev.mat
RRMSofGaussChebyshev = RRMS;

load Data\RRMSofGaussLegendre.mat
RRMSofGaussLegendre = RRMS;

load Data\RRMSofRadau.mat
RRMSofRadau = RRMS;

load Data\RRMSofLobatto.mat
RRMSofLobatto = RRMS;

%% plot the figure
figure

obj = {'g_x','g_y','g_z','U_{xx}','U_{xy}','U_{xz}','U_{yy}','U_{yz}','U_{zz}'};
figname = {'Gx','Gy','Gz','Uxx','Uxy','Uxz','Uyy','Uyz','Uzz'};
% p = [1 2 3 4 5 6 8 9 12];
for k = 1:9

    % subplot(4,3,p(k))

    plot(n,RRMSofGaussChebyshev(2:18,k),'-+','LineWidth',1.3,'MarkerSize',5)
    hold on
    plot(n,RRMSofGaussLegendre(2:18,k),'-+','LineWidth',1.3,'MarkerSize',5)
    hold on
    plot(n,RRMSofRadau(2:18,k),'-+','LineWidth',1.3,'MarkerSize',5)
    hold on
    plot(n,RRMSofLobatto(2:18,k),'-+','LineWidth',1.3,'MarkerSize',5)
    hold on
    plot(n,RRMSofIntegral3(k)*ones(1,17),':','LineWidth',1.5,'MarkerSize',5)
    grid on

    gx = gca;
    gx.YScale = 'log';
    gx.XLabel.String = 'Number of abscissas';
    gx.Title.String = ['RRMS of ',obj{k}];
    gx.FontName = 'Times New Roman';
    gx.FontSize = 13;

    legend('Gauss-Chebyshev quadrature','Gauss-Legendre quadrature','Radau quadrature','Lobatto quadrature','Integral3','Location','southwest')
    
    saveas(gcf, ['Figure/RRMSof',figname{k},'.png'])
    saveas(gcf, ['Figure/RRMSof',figname{k},'.eps'])
    saveas(gcf, ['Figure/RRMSof',figname{k},'.fig'])
end