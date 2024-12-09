function [w,x] = GaussChebyshevCoef(n)
%GaussChebyshevCoef Calculate Gauss-Legendre quadrature coefficients and
%Gaussian points.
%
%   [w,x] = GaussChebyshevCoef(n)
%
%   Input
%       n - number of Gaussian points
%   Output
%       w - Gauss-Chebyshev quadrature coefficients
%       x - Gaussian points
%

    w = pi/n*ones(1,n);
    x = cos(((1:n)-0.5)*pi/n);

end