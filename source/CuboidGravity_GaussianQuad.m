function values = CuboidGravity_GaussianQuad(model,area,options)
%CuboidGravity Gaussian quadrature method is used to calculate cuboid
%              gravity anomalies.
%
%   values = CuboidGravity_GaussianQuad(model)
%   values = CuboidGravity_GaussianQuad(model,area)
%   values = CuboidGravity_GaussianQuad(model,area,'method','gl','n',n)
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
    
    [xi,yj,zk,W] = GaussianCoef3(model,options.n,options.method);

    [X, Y] = meshgrid(area(1,:), area(2,:));

    gx = Gp*arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_gx(x, y, 0), xi, yj, zk, W), X, Y);
    gy = Gp*arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_gy(x, y, 0), xi, yj, zk, W), X, Y);
    gz = Gp*arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_gz(x, y, 0), xi, yj, zk, W), X, Y);
    uxx = Gp*1e3*arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uxx(x, y, 0), xi, yj, zk, W), X, Y);
    uxy = Gp*1e3*arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uxy(x, y, 0), xi, yj, zk, W), X, Y);
    uxz = Gp*1e3*arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uxz(x, y, 0), xi, yj, zk, W), X, Y);
    uyy = Gp*1e3*arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uyy(x, y, 0), xi, yj, zk, W), X, Y);
    uyz = Gp*1e3*arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uyz(x, y, 0), xi, yj, zk, W), X, Y);
    uzz = Gp*1e3*arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uzz(x, y, 0), xi, yj, zk, W), X, Y);

    values = {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};

end