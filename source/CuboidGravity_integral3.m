function values = CuboidGravity_integral3(model,area)
%CuboidGravity_integral3 The matlab built-in function integral3 is used 
%                        to calculate the cuboid gravity anomaly.
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

    
    for i = 1:Y
        for j = 1:X
        gx(i,j) = integral3(CuboidIntegrand_gx(x(j),y(i),0),a1,a2,b1,b2,c1,c2);
        gy(i,j) = integral3(CuboidIntegrand_gy(x(j),y(i),0),a1,a2,b1,b2,c1,c2);
        gz(i,j) = integral3(CuboidIntegrand_gz(x(j),y(i),0),a1,a2,b1,b2,c1,c2);
        uxx(i,j) = integral3(CuboidIntegrand_uxx(x(j),y(i),0),a1,a2,b1,b2,c1,c2);
        uxy(i,j) = integral3(CuboidIntegrand_uxy(x(j),y(i),0),a1,a2,b1,b2,c1,c2);
        uxz(i,j) = integral3(CuboidIntegrand_uxz(x(j),y(i),0),a1,a2,b1,b2,c1,c2);
        uyy(i,j) = integral3(CuboidIntegrand_uyy(x(j),y(i),0),a1,a2,b1,b2,c1,c2);
        uyz(i,j) = integral3(CuboidIntegrand_uyz(x(j),y(i),0),a1,a2,b1,b2,c1,c2);
        uzz(i,j) = integral3(CuboidIntegrand_uzz(x(j),y(i),0),a1,a2,b1,b2,c1,c2);
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