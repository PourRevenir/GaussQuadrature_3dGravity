function varargout = CuboidGravity_integral3(model,area)
%CuboidGravityAnomaly Calculate cuboid gravity anomalies and plot
%images.The matlab built-in function integral3 is used to calculate the
%cuboid gravity anomaly.
% 
%   values = CuboidGravity_integral3(model)
%   values = CuboidGravity_integral3(model,area)
%   
%   Input
%       model - [a1,a2,b1,b2,c1,c2,density]
%       area - [x;y] x,y is a row vector
%
%   Output
%       values - {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};
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

    
    for i = 1:X
        for j = 1:Y
        gx(i,j) = integral3(Integrand_gx(x(i),y(j),0),a1,a2,b1,b2,c1,c2);
        gy(i,j) = integral3(Integrand_gy(x(i),y(j),0),a1,a2,b1,b2,c1,c2);
        gz(i,j) = integral3(Integrand_gz(x(i),y(j),0),a1,a2,b1,b2,c1,c2);
        uxx(i,j) = integral3(Integrand_uxx(x(i),y(j),0),a1,a2,b1,b2,c1,c2);
        uxy(i,j) = integral3(Integrand_uxy(x(i),y(j),0),a1,a2,b1,b2,c1,c2);
        uxz(i,j) = integral3(Integrand_uxz(x(i),y(j),0),a1,a2,b1,b2,c1,c2);
        uyy(i,j) = integral3(Integrand_uyy(x(i),y(j),0),a1,a2,b1,b2,c1,c2);
        uyz(i,j) = integral3(Integrand_uyz(x(i),y(j),0),a1,a2,b1,b2,c1,c2);
        uzz(i,j) = integral3(Integrand_uzz(x(i),y(j),0),a1,a2,b1,b2,c1,c2);
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