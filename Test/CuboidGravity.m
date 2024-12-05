function varargout = CuboidGravity(model,area,options)
%CuboidGravityAnomaly Calculate cuboid gravity anomalies and plot images.
% 
%   value = CuboidGravity(model)
%   value = CuboidGravity(model,area)
%   value = CuboidGravity(model,area,method='gleg')
%   value = CuboidGravity(model,area,'method','gleg','n',n)
%
%   Input
%       model - [a1,a2,b1,b2,c1,c2,density]
%       area - [x;y] x,y is a row vector
%       method - 'gleg', 'gche', 'grad', 'glob'
%       n - [n1,n2,n3]
%
arguments
    model(1,7) {mustBeNumeric(model)}
    area(2,:)  {mustBeNumeric(area)} = ObservationPlane(model)
    options.method(1,1) string {mustBeMember(options.method,{'gleg','gche','grad','glob'})} = 'gleg'
    options.n(1,3) {mustBeNumeric(options.n)} = [5,5,5]
end
G = 6.67408e-11;

x = area(1,:);
y = area(2,:);
X = length(x);
Y = length(y);
[xx,yy] = meshgrid(x,y);

gx = zeros(X,Y);
gy = zeros(X,Y);
gz = zeros(X,Y);
uxx = zeros(X,Y);
uyy = zeros(X,Y);
uzz = zeros(X,Y);
uxy = zeros(X,Y);
uxz = zeros(X,Y);
uyz = zeros(X,Y);

switch options.method
    case 'gleg'
        figure("Name",'using Gauss-Legendre quadrature')
        [xi,yj,zk,wi,wj,wk] = GaussLegendreCoef3(model,options.n);
        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gx',x(i),y(j),0);
            gx(i,j) = GaussLegendreQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gx = G*model(7)*gx;
        subplot(4,3,1)
        contourf(xx,yy,gx')
        xlabel('x')
        ylabel('y')
        title('gx')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gy',x(i),y(j),0);
            gy(i,j) = GaussLegendreQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gy = G*model(7)*gy;
        subplot(4,3,2)
        contourf(xx,yy,gy')
        xlabel('x')
        ylabel('y')
        title('gy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gz',x(i),y(j),0);
            gz(i,j) = GaussLegendreQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gz = G*model(7)*gz;
        subplot(4,3,3)
        contourf(xx,yy,gz')
        xlabel('x')
        ylabel('y')
        title('gz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxx',x(i),y(j),0);
            uxx(i,j) = GaussLegendreQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxx = G*model(7)*uxx;
        subplot(4,3,4)
        contourf(xx,yy,uxx')
        xlabel('x')
        ylabel('y')
        title('uxx')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxy',x(i),y(j),0);
            uxy(i,j) = GaussLegendreQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxy = G*model(7)*uxy;
        subplot(4,3,5)
        contourf(xx,yy,uxy')
        xlabel('x')
        ylabel('y')
        title('uxy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxz',x(i),y(j),0);
            uxz(i,j) = GaussLegendreQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxz = G*model(7)*uxz;
        subplot(4,3,6)
        contourf(xx,yy,uxz')
        xlabel('x')
        ylabel('y')
        title('uxz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uyy',x(i),y(j),0);
            uyy(i,j) = GaussLegendreQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uyy = G*model(7)*uyy;
        subplot(4,3,8)
        contourf(xx,yy,uyy')
        xlabel('x')
        ylabel('y')
        title('uyy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uyz',x(i),y(j),0);
            uyz(i,j) = GaussLegendreQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uyz = G*model(7)*uyz;
        subplot(4,3,9)
        contourf(xx,yy,uyz')
        xlabel('x')
        ylabel('y')
        title('uyz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uzz',x(i),y(j),0);
            uzz(i,j) = GaussLegendreQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uzz = G*model(7)*uzz;
        subplot(4,3,12)
        contourf(xx,yy,uzz')
        xlabel('x')
        ylabel('y')
        title('uzz')
        axis image
        colorbar

    case 'gche'
        figure("Name",'using Gauss-Chebyshev quadrature')
        [xi,yj,zk,wi,wj,wk] = GaussChebyshevCoef3(model,options.n);
        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gx',x(i),y(j),0);
            gx(i,j) = GaussChebyshevQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gx = G*model(7)*gx;
        subplot(4,3,1)
        contourf(xx,yy,gx')
        xlabel('x')
        ylabel('y')
        title('gx')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gy',x(i),y(j),0);
            gy(i,j) = GaussChebyshevQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gy = G*model(7)*gy;
        subplot(4,3,2)
        contourf(xx,yy,gy')
        xlabel('x')
        ylabel('y')
        title('gy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gz',x(i),y(j),0);
            gz(i,j) = GaussChebyshevQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gz = G*model(7)*gz;
        subplot(4,3,3)
        contourf(xx,yy,gz')
        xlabel('x')
        ylabel('y')
        title('gz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxx',x(i),y(j),0);
            uxx(i,j) = GaussChebyshevQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxx = G*model(7)*uxx;
        subplot(4,3,4)
        contourf(xx,yy,uxx')
        xlabel('x')
        ylabel('y')
        title('uxx')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxy',x(i),y(j),0);
            uxy(i,j) = GaussChebyshevQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxy = G*model(7)*uxy;
        subplot(4,3,5)
        contourf(xx,yy,uxy')
        xlabel('x')
        ylabel('y')
        title('uxy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxz',x(i),y(j),0);
            uxz(i,j) = GaussChebyshevQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxz = G*model(7)*uxz;
        subplot(4,3,6)
        contourf(xx,yy,uxz')
        xlabel('x')
        ylabel('y')
        title('uxz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uyy',x(i),y(j),0);
            uyy(i,j) = GaussChebyshevQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uyy = G*model(7)*uyy;
        subplot(4,3,8)
        contourf(xx,yy,uyy')
        xlabel('x')
        ylabel('y')
        title('uyy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uyz',x(i),y(j),0);
            uyz(i,j) = GaussChebyshevQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uyz = G*model(7)*uyz;
        subplot(4,3,9)
        contourf(xx,yy,uyz')
        xlabel('x')
        ylabel('y')
        title('uyz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uzz',x(i),y(j),0);
            uzz(i,j) = GaussChebyshevQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uzz = G*model(7)*uzz;
        subplot(4,3,12)
        contourf(xx,yy,uzz')
        xlabel('x')
        ylabel('y')
        title('uzz')
        axis image
        colorbar

    case 'grad'
        figure("Name",'using Gauss-Radau quadrature')
        [xi,yj,zk,wi,wj,wk] = GaussRadauCoef3(model,options.n);
        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gx',x(i),y(j),0);
            gx(i,j) = GaussRadauQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gx = G*model(7)*gx;
        subplot(4,3,1)
        contourf(xx,yy,gx')
        xlabel('x')
        ylabel('y')
        title('gx')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gy',x(i),y(j),0);
            gy(i,j) = GaussRadauQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gy = G*model(7)*gy;
        subplot(4,3,2)
        contourf(xx,yy,gy')
        xlabel('x')
        ylabel('y')
        title('gy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gz',x(i),y(j),0);
            gz(i,j) = GaussRadauQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gz = G*model(7)*gz;
        subplot(4,3,3)
        contourf(xx,yy,gz')
        xlabel('x')
        ylabel('y')
        title('gz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxx',x(i),y(j),0);
            uxx(i,j) = GaussRadauQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxx = G*model(7)*uxx;
        subplot(4,3,4)
        contourf(xx,yy,uxx')
        xlabel('x')
        ylabel('y')
        title('uxx')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxy',x(i),y(j),0);
            uxy(i,j) = GaussRadauQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxy = G*model(7)*uxy;
        subplot(4,3,5)
        contourf(xx,yy,uxy')
        xlabel('x')
        ylabel('y')
        title('uxy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxz',x(i),y(j),0);
            uxz(i,j) = GaussRadauQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxz = G*model(7)*uxz;
        subplot(4,3,6)
        contourf(xx,yy,uxz')
        xlabel('x')
        ylabel('y')
        title('uxz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uyy',x(i),y(j),0);
            uyy(i,j) = GaussRadauQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uyy = G*model(7)*uyy;
        subplot(4,3,8)
        contourf(xx,yy,uyy')
        xlabel('x')
        ylabel('y')
        title('uyy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uyz',x(i),y(j),0);
            uyz(i,j) = GaussRadauQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uyz = G*model(7)*uyz;
        subplot(4,3,9)
        contourf(xx,yy,uyz')
        xlabel('x')
        ylabel('y')
        title('uyz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uzz',x(i),y(j),0);
            uzz(i,j) = GaussRadauQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uzz = G*model(7)*uzz;
        subplot(4,3,12)
        contourf(xx,yy,uzz')
        xlabel('x')
        ylabel('y')
        title('uzz')
        axis image
        colorbar

    case 'glob'
        figure("Name",'using Gauss-Lobatto quadrature')
        [xi,yj,zk,wi,wj,wk] = GaussLobattoCoef3(model,options.n);
        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gx',x(i),y(j),0);
            gx(i,j) = GaussLobattoQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gx = G*model(7)*gx;
        subplot(4,3,1)
        contourf(xx,yy,gx')
        xlabel('x')
        ylabel('y')
        title('gx')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gy',x(i),y(j),0);
            gy(i,j) = GaussLobattoQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gy = G*model(7)*gy;
        subplot(4,3,2)
        contourf(xx,yy,gy')
        xlabel('x')
        ylabel('y')
        title('gy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('gz',x(i),y(j),0);
            gz(i,j) = GaussLobattoQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        gz = G*model(7)*gz;
        subplot(4,3,3)
        contourf(xx,yy,gz')
        xlabel('x')
        ylabel('y')
        title('gz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxx',x(i),y(j),0);
            uxx(i,j) = GaussLobattoQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxx = G*model(7)*uxx;
        subplot(4,3,4)
        contourf(xx,yy,uxx')
        xlabel('x')
        ylabel('y')
        title('uxx')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxy',x(i),y(j),0);
            uxy(i,j) = GaussLobattoQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxy = G*model(7)*uxy;
        subplot(4,3,5)
        contourf(xx,yy,uxy')
        xlabel('x')
        ylabel('y')
        title('uxy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uxz',x(i),y(j),0);
            uxz(i,j) = GaussLobattoQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uxz = G*model(7)*uxz;
        subplot(4,3,6)
        contourf(xx,yy,uxz')
        xlabel('x')
        ylabel('y')
        title('uxz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uyy',x(i),y(j),0);
            uyy(i,j) = GaussLobattoQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uyy = G*model(7)*uyy;
        subplot(4,3,8)
        contourf(xx,yy,uyy')
        xlabel('x')
        ylabel('y')
        title('uyy')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uyz',x(i),y(j),0);
            uyz(i,j) = GaussLobattoQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uyz = G*model(7)*uyz;
        subplot(4,3,9)
        contourf(xx,yy,uyz')
        xlabel('x')
        ylabel('y')
        title('uyz')
        axis image
        colorbar

        for i = 1:X
            for j = 1:Y
            f = IntegrandFunc('uzz',x(i),y(j),0);
            uzz(i,j) = GaussLobattoQuad3(f,xi,yj,zk,wi,wj,wk);
            end
        end
        uzz = G*model(7)*uzz;
        subplot(4,3,12)
        contourf(xx,yy,uzz')
        xlabel('x')
        ylabel('y')
        title('uzz')
        axis image
        colorbar

end

varargout = {gx,gy,gz,uxx,uyy,uzz,uxy,uxz,uyz};

end