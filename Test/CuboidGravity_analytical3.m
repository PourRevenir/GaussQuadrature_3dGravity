function varargout = CuboidGravity_analytical3(model,area)
%CuboidGravity_analytical3 Calculate cuboid gravity anomalies and plot
%images. The cuboid gravity anomaly is calculated using the analytic solution
% 
%   value = CuboidGravity_analytical3(model)
%   value = CuboidGravity_analytical3(model,area)
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
end