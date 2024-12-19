function values = CuboidGravity_GaussianQuad(model,area,options)
%CuboidGravity Gaussian quadrature method is used to calculate cuboid
%              gravity anomalies.
%
%   values = CuboidGravity(model)
%   values = CuboidGravity(model,area)
%   values = CuboidGravity(model,area,'method','gleg','n',n)
%
%   Input
%       model - [a1,a2,b1,b2,c1,c2,density]
%       area - [x;y]
%       method - 'gl','gc','r','l'
%
%   Output
%       values - {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz}
%
arguments
    model(1,7) {mustBeNumeric(model)}
    area(2,:) {mustBeNumeric(area)} = ObservationPlane(model)
    options.method(1,1) string {mustBeMember(options.method,{'gl','gc','r','l'})} = 'gl'
    options.n(1,3) {mustBeNumeric(options.n)} = [5,5,5];
end

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

    [xi,yj,zk,W] = GaussianCoef3(model,options.n,options.method);

    for i = 1:Y
        for j = 1:X
        gx(i,j) = GaussianQuad3(CuboidIntegrand_gx(x(j),y(i),0),xi,yj,zk,W);
        gy(i,j) = GaussianQuad3(CuboidIntegrand_gy(x(j),y(i),0),xi,yj,zk,W);
        gz(i,j) = GaussianQuad3(CuboidIntegrand_gz(x(j),y(i),0),xi,yj,zk,W);
        uxx(i,j) = GaussianQuad3(CuboidIntegrand_uxx(x(j),y(i),0),xi,yj,zk,W);
        uxy(i,j) = GaussianQuad3(CuboidIntegrand_uxy(x(j),y(i),0),xi,yj,zk,W);
        uxz(i,j) = GaussianQuad3(CuboidIntegrand_uxz(x(j),y(i),0),xi,yj,zk,W);
        uyy(i,j) = GaussianQuad3(CuboidIntegrand_uyy(x(j),y(i),0),xi,yj,zk,W);
        uyz(i,j) = GaussianQuad3(CuboidIntegrand_uyz(x(j),y(i),0),xi,yj,zk,W);
        uzz(i,j) = GaussianQuad3(CuboidIntegrand_uzz(x(j),y(i),0),xi,yj,zk,W);
        end
    end

    gx = Gp*gx;
    gy = Gp*gy;
    gz = Gp*gz;
    uxx = Gp*uxx*1e3;
    uxy = Gp*uxy*1e3;
    uxz = Gp*uxz*1e3;
    uyy = Gp*uyy*1e3;
    uyz = Gp*uyz*1e3;
    uzz = Gp*uzz*1e3;

    values = {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};

end