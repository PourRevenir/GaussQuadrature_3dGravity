function values = CuboidGravity_analytical(model,area)
%CuboidGravity_analytical The cuboid gravity anomaly is calculated 
%                         using the analytic solution
% 
%   values = CuboidGravity_analytical(model)
%   values = CuboidGravity_analytical(model,area)
%   
%   Input
%       model - [a1,a2,b1,b2,c1,c2,density]
%       area - [x;y] x,y is a row vector
%
%   Output
%       values - {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz}
%    
arguments
    model(1,7) {mustBeNumeric(model)}
    area(2,:)  {mustBeNumeric(area)} = ObservationPlane(model)
end

    G = 6.67408e-6;
    Gp = G*model(7);

    x = area(1,:);
    y = area(2,:);

    gw =@(u,v,w,r) u*log(v+r)+v*log(u+r)-w*atan(u*v/(w*r));
    Tww =@(u,v,w,r) atan(u*v/ (w*r));
    Tuv =@(u,v,w,r) log(r+w);
    
    dx = [model(1)-x;model(2)-x];
    dy = [model(3)-y;model(4)-y];
    dz = [model(5);model(6)];

    [X, Y] = meshgrid(1:length(x), 1:length(y));
  
    gx = -Gp*arrayfun(@(j, i) CuboidAnalytical(gw, dy(:,i), dz, dx(:,j)), X, Y);
    gy = -Gp*arrayfun(@(j, i) CuboidAnalytical(gw, dz, dx(:,j), dy(:,i)), X, Y);
    gz = -Gp*arrayfun(@(j, i) CuboidAnalytical(gw, dx(:,j), dy(:,i), dz), X, Y);
    uxx = -Gp*1e3*arrayfun(@(j, i) CuboidAnalytical(Tww, dy(:,i), dz, dx(:,j)), X, Y);
    uxy = Gp*1e3*arrayfun(@(j, i) CuboidAnalytical(Tuv, dx(:,j), dy(:,i), dz), X, Y);
    uxz = Gp*1e3*arrayfun(@(j, i) CuboidAnalytical(Tuv, dz, dx(:,j), dy(:,i)), X, Y);
    uyy = -Gp*1e3*arrayfun(@(j, i) CuboidAnalytical(Tww, dz, dx(:,j), dy(:,i)), X, Y);
    uyz = Gp*1e3*arrayfun(@(j, i) CuboidAnalytical(Tuv, dy(:,i), dz, dx(:,j)), X, Y);
    uzz = -Gp*1e3*arrayfun(@(j, i) CuboidAnalytical(Tww, dx(:,j), dy(:,i), dz), X, Y);

    values = {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};

end