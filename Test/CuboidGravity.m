function CuboidGravity(model,area,options)
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
    area(2,:)  {mustBeNumeric(area)} = [-50:50;-50:50]
    options.method(1,1) string {mustBeMember(options.method,{'gleg','gche','grad','glob'})} = 'gleg'
    options.n(1,3) {mustBeNumeric(options.n)} = [8,8,8]
end
x = area(1,:);
y = area(2,:);
X = length(x);
Y = length(y);
[xx,yy] = meshgrid(x,y);

u = zeros(X,Y);

switch options.method
    case 'gleg'
        figure(1)
        [xi,yj,zk,wi,wj,wk] = GaussLegendreCoef3(model,options.n);
        for i = 1:X
            for j = 1:Y
            gx = IntegrandFunc('gx',x(i),y(j),0);
            u(i,j) = GaussLegendreQuad3(gx,xi,yj,zk,wi,wj,wk);
            end
        end
        subplot(3,3,1)
        contourf(xx,yy,u)
        colorbar

    case 'gche'

    case 'grad'

    case 'glob'

end



[x,y] = meshgrid(x,y);
contourf(x,y,u);
colorbar
end