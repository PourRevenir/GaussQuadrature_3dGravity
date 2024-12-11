clearvars

model = [-50,50,-50,50,-150,-50,1000];
area = ObservationPlane(model);

G = 6.67408e-6;
Gp = G*model(7);

x = area(1,:);
y = area(2,:);
X = length(x);
Y = length(y);

gx = zeros(X,Y);
gy = zeros(X,Y);
gz = zeros(X,Y);
uxx = zeros(X,Y);
uxy = zeros(X,Y);
uxz = zeros(X,Y);
uyy = zeros(X,Y);
uyz = zeros(X,Y);
uzz = zeros(X,Y);

gw =@(u,v,w,r) u*log(w+r)+v*log(w+r)-w*atan(u*v/w/r);
Tww =@(u,v,w,r) atan(u*v/w/r);
Tuv =@(u,v,w,r) log(r+w);

Dx = [model(1)-x;model(2)-x];
Dy = [model(3)-y;model(4)-y];
dz = [model(5);model(6)];

for i = 1:Y
    dy = Dy(:,i);
    for j = 1:X
        dx = Dx(:,j);
        r = [sqrt(dx(1)^2+dy(1)^2+dz(1)^2),sqrt(dx(2)^2+dy(2)^2+dz(2)^2)];
        gx(i,j) = CuboidAnalytical(gw,dy,dz,dx,r);
        gy(i,j) = CuboidAnalytical(gw,dz,dx,dy,r);
        gz(i,j) = CuboidAnalytical(gw,dx,dy,dz,r);
        uxx(i,j) = CuboidAnalytical(Tww,dy,dz,dx,r);
        uxy(i,j) = CuboidAnalytical(Tuv,dx,dy,dz,r);
        uxz(i,j) = CuboidAnalytical(Tuv,dz,dx,dy,r);
        uyy(i,j) = CuboidAnalytical(Tww,dz,dx,dy,r);
        uyz(i,j) = CuboidAnalytical(Tuv,dy,dz,dx,r);
        uzz(i,j) = CuboidAnalytical(Tww,dx,dy,dz,r);
    end
end

gx = -Gp*gx;
gy = -Gp*gy;
gz = -Gp*gz;
uxx = Gp*uxx;
uxy = -Gp*uxy;
uxz = -Gp*uxz;
uyy = Gp*uyy;
uyz = -Gp*uyz;
uzz = Gp*uzz;

values = {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};