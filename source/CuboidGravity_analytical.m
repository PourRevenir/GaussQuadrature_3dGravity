function values = CuboidGravity_analytical(model,area)
%CuboidGravity_analytical1 Calculate cuboid gravity anomalies and plot
%images. The cuboid gravity anomaly is calculated using the analytic solution
% 
%   values = CuboidGravity_analytical1(model)
%   values = CuboidGravity_analytical1(model,area)
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

    gw =@(u,v,w,r) u*log(v+r)+v*log(u+r)-w*atan(u*v/(w*r));
    Tww =@(u,v,w,r) atan(u*v/ (w*r));
    Tuv =@(u,v,w,r) log(r+w);
    
    Dx = [model(1)-x;model(2)-x];
    Dy = [model(3)-y;model(4)-y];
    dz = [model(5);model(6)];
  
    for i = 1:Y
        dy = Dy(:,i);
        for j = 1:X
            dx = Dx(:,j);
            gx(i,j) = CuboidAnalytical(gw,dy,dz,dx);
            gy(i,j) = CuboidAnalytical(gw,dz,dx,dy);  
            gz(i,j) = CuboidAnalytical(gw,dx,dy,dz);
            uxx(i,j) = CuboidAnalytical(Tww,dy,dz,dx);
            uxy(i,j) = CuboidAnalytical(Tuv,dx,dy,dz);
            uxz(i,j) = CuboidAnalytical(Tuv,dz,dx,dy);
            uyy(i,j) = CuboidAnalytical(Tww,dz,dx,dy);
            uyz(i,j) = CuboidAnalytical(Tuv,dy,dz,dx);
            uzz(i,j) = CuboidAnalytical(Tww,dx,dy,dz);
        end
    end

    gx = -Gp*gx;
    gy = -Gp*gy;
    gz = -Gp*gz;
    uxx = -Gp*uxx;
    uxy = Gp*uxy;
    uxz = Gp*uxz;
    uyy = -Gp*uyy;
    uyz = Gp*uyz;
    uzz = -Gp*uzz;

    values = {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};

end