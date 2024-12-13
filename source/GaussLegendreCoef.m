function [w,x] = GaussLegendreCoef(n)
%GaussLegendreCoef Calculate Gauss-Legendre quadrature coefficients and
%Gaussian points.
%
%   [w,x] = GaussLegendreCoef(n)
%
%   Input
%       n - number of Gaussian points
%   Output
%       w - Gauss-Legendre quadrature coefficients
%       x - Gaussian points
%

    beta  = 0.5./sqrt(1-(2*(1:n-1)).^(-2));
    T     = diag(beta,1) + diag(beta,-1);
    [V,D] = eig(T);
    x = diag(D);
    w     = 2*V(1,:)'.^2;
    
end