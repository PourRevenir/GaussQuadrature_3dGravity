function [w,x] = GaussChebyshevCoef(n)
%GaussChebyshevCoef Calculate Gauss-Chebyshev quadrature weights 
%                   and optimal abscissas.
%
%   [w,x] = GaussChebyshevCoef(n)
%
%   Input
%       n - number of optimal abscissas
%   Output
%       w - Gauss-Chebyshev quadrature weights
%       x - optimal abscissas
%

    x = cos(((1:n)-0.5)*pi/n);
    w = pi/n*ones(1,n).*sqrt(1-x.^2);
end