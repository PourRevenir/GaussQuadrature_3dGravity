function varargout = CuboidGravity_GaussLobatto(model,area,n)
%CuboidGravity_GaussLobatto Gauss-Lobatto quadrature is used to
%calculate cuboid gravity anomalies.
%
%   values = CuboidGravity_GaussLobatto(model)
%   values = CuboidGravity_GaussLobatto(model,area)
%   values = CuboidGravity_GaussLobatto(model,area,n)
%
%   Input
%       model - [a1,a2,b1,b2,c1,c2,density]
%       area - [x;y] x,y is a row vector
%       n - [n1,n2,n3]
%
%   Output
%       values - {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};
%
arguments
    model(1,7) {mustBeNumeric(model)}
    area(2,:)  {mustBeNumeric(area)} = ObservationPlane(model)
    n(1,3)     {mustBeNumeric(n)} = [5,5,5]
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

    [xi,yj,zk,W] = GaussLobattoCoef3(model,n);

    for i = 1:X
        for j = 1:Y
        gx(i,j) = GaussLobattoQuad3(Integrand_gx(x(i),y(j),0),xi,yj,zk,W);
        gy(i,j) = GaussLobattoQuad3(Integrand_gy(x(i),y(j),0),xi,yj,zk,W);
        gz(i,j) = GaussLobattoQuad3(Integrand_gz(x(i),y(j),0),xi,yj,zk,W);
        uxx(i,j) = GaussLobattoQuad3(Integrand_uxx(x(i),y(j),0),xi,yj,zk,W);
        uxy(i,j) = GaussLobattoQuad3(Integrand_uxy(x(i),y(j),0),xi,yj,zk,W);
        uxz(i,j) = GaussLobattoQuad3(Integrand_uxz(x(i),y(j),0),xi,yj,zk,W);
        uyy(i,j) = GaussLobattoQuad3(Integrand_uyy(x(i),y(j),0),xi,yj,zk,W);
        uyz(i,j) = GaussLobattoQuad3(Integrand_uyz(x(i),y(j),0),xi,yj,zk,W);
        uzz(i,j) = GaussLobattoQuad3(Integrand_uzz(x(i),y(j),0),xi,yj,zk,W);
        end
    end

    gx = Gp*gx;
    gy = Gp*gy;
    gz = Gp*gz;
    uxx = Gp*uxx;
    uxy = Gp*uxy;
    uxz = Gp*uxz;
    uyy = Gp*uyy;
    uyz = Gp*uyz;
    uzz = Gp*uzz;

    varargout = {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};

end