function varargout = CuboidGravity_integral3(model,area)
%CuboidGravityAnomaly Calculate cuboid gravity anomalies and plot
%images.The matlab built-in function integral3 is used to calculate the
%cuboid gravity anomaly.
% 
%   value = CuboidGravity_integral3(model)
%   value = CuboidGravity_integral3(model,area)
%   
%   Input
%       model - [a1,a2,b1,b2,c1,c2,density]
%       area - [x;y] x,y is a row vector
%       
arguments
    model(1,7) {mustBeNumeric(model)}
    area(2,:)  {mustBeNumeric(area)} = ObservationPlane(model)
end

G = 6.67408e-6;

x = area(1,:);
y = area(2,:);
X = length(x);
Y = length(y);
[xx,yy] = meshgrid(x,y);

a1 = model(1);
a2 = model(2);
b1 = model(3);
b2 = model(4);
c1 = model(5);
c2 = model(6);

gx = zeros(X,Y);
gy = zeros(X,Y);
gz = zeros(X,Y);
uxx = zeros(X,Y);
uyy = zeros(X,Y);
uzz = zeros(X,Y);
uxy = zeros(X,Y);
uxz = zeros(X,Y);
uyz = zeros(X,Y);

figure("Name",'using integral3')
for i = 1:X
    for j = 1:Y
        f = IntegrandFunc('gx',x(i),y(j),0);
        gx(i,j) = integral3(f,a1,a2,b1,b2,c1,c2);
    end
end
gx = G*model(7)*gx;
subplot(4,3,1)
contourf(xx,yy,gx')
xlabel('x')
ylabel('y')
title('gx')
colorbar

for i = 1:X
    for j = 1:Y
        f = IntegrandFunc('gy',x(i),y(j),0);
        gy(i,j) = integral3(f,a1,a2,b1,b2,c1,c2);
    end
end
gy = G*model(7)*gy;
subplot(4,3,2)
contourf(xx,yy,gy')
xlabel('x')
ylabel('y')
title('gy')
colorbar

for i = 1:X
    for j = 1:Y
        f = IntegrandFunc('gz',x(i),y(j),0);
        gz(i,j) = integral3(f,a1,a2,b1,b2,c1,c2);
    end
end
gz = G*model(7)*gz;
subplot(4,3,3)
contourf(xx,yy,gz')
xlabel('x')
ylabel('y')
title('gz')
colorbar

for i = 1:X
    for j = 1:Y
        f = IntegrandFunc('uxx',x(i),y(j),0);
        uxx(i,j) = integral3(f,a1,a2,b1,b2,c1,c2);
    end
end
uxx = G*model(7)*uxx;
subplot(4,3,4)
contourf(xx,yy,uxx')
xlabel('x')
ylabel('y')
title('uxx')
colorbar

for i = 1:X
    for j = 1:Y
        f = IntegrandFunc('uxy',x(i),y(j),0);
        uxy(i,j) = integral3(f,a1,a2,b1,b2,c1,c2);
    end
end
uxy = G*model(7)*uxy;
subplot(4,3,5)
contourf(xx,yy,uxy')
xlabel('x')
ylabel('y')
title('uxy')
colorbar

for i = 1:X
    for j = 1:Y
        f = IntegrandFunc('uxz',x(i),y(j),0);
        uxz(i,j) = integral3(f,a1,a2,b1,b2,c1,c2);
    end
end
uxz = G*model(7)*uxz;
subplot(4,3,6)
contourf(xx,yy,uxz')
xlabel('x')
ylabel('y')
title('uxz')
colorbar

for i = 1:X
    for j = 1:Y
        f = IntegrandFunc('uyy',x(i),y(j),0);
        uyy(i,j) = integral3(f,a1,a2,b1,b2,c1,c2);
    end
end
uyy = G*model(7)*uyy;
subplot(4,3,8)
contourf(xx,yy,uyy')
xlabel('x')
ylabel('y')
title('uyy')
colorbar

for i = 1:X
    for j = 1:Y
        f = IntegrandFunc('uyz',x(i),y(j),0);
        uyz(i,j) = integral3(f,a1,a2,b1,b2,c1,c2);
    end
end
uyz = G*model(7)*uyz;
subplot(4,3,9)
contourf(xx,yy,uyz')
xlabel('x')
ylabel('y')
title('uyz')
colorbar

for i = 1:X
    for j = 1:Y
        f = IntegrandFunc('uzz',x(i),y(j),0);
        uzz(i,j) = integral3(f,a1,a2,b1,b2,c1,c2);
    end
end
uzz = G*model(7)*uzz;
subplot(4,3,12)
contourf(xx,yy,uzz')
xlabel('x')
ylabel('y')
title('uzz')
colorbar

varargout = {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};

end