function [w,x] = ClenshawCurtisCoef(n)
%ClenshawCurtisCoef Calculate ClenshawCurtis quadrature weights and
%abscissas.
%
%   [w,x] = ClenshawCurtisCoef(n)
%
%   Input
%       n - number of abscissas
%   Output
%       w - ClenshawCurtis quadrature weights
%       x - abscissas
%

    x = -cos((1:n)*pi/n);
    

end