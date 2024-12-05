function area = ObservationPlane(model)
%ObservingPlane The appropriate observation plane is automatically
%generated according to the model.
% 
%   area = ObservationPlane(model)
%       
%   Input
%       model - [a1,a2,b1,b2,c1,c2,density]
% 
%   Output
%       area - [x;y]
% 

    xl = 2*model(1)-model(2);
    xr = -model(1)+2*model(2);
    dx = 0.02*xr-0.02*xl;

    yl = 2*model(3)-model(4);
    yr = -model(3)+2*model(4);
    dy = 0.02*yr-0.02*yl;

    x = xl:dx:xr;
    y = yl:dy:yr;
    area = [x;y];

end