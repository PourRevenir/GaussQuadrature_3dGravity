function [w,x] = GaussLobattoCoef(n)
%GaussRadauCoef Calculate Gauss-Radau quadrature coefficients and
%Gaussian points.
%
%   [w,x] = GaussRadauCoef(n)
%
%   Input
%       n - number of Gaussian points
%   Output
%       w - Gauss-Radau quadrature coefficients
%       x - Gaussian points
%

    polyPrevious = 1;
    polyCurrent = [1 0];

    for i = 1:n-1
        polyForward = [polyCurrent*(2*i+1)/(i+1) 0];
        polyForward = polyForward - [0 0 polyPrevious*i/(i+1)];
        polyPrevious = polyCurrent;
        polyCurrent = polyForward;
    end
    
    x = roots(polydiv([polyPrevious 0]-polyCurrent,[-1 0 1]));
    w = 2./(n*(n-1)*(polyval(polyPrevious,x)).^2);

    x = [-1;1;x];
    w = [2/(n*(n-1));2/(n*(n-1));w];
end