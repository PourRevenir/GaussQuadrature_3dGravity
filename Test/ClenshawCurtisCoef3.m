function [w,x] = ClenshawCurtisCoef3(n)
%ClenshawCurtisCoef3 Calculate ClenshawCurtis quadrature weights and
%abscissas.
%
%   [w,x] = ClenshawCurtisCoef3(n)
%
%   Input
%       n - number of abscissas
%   Output
%       w - ClenshawCurtis quadrature weights
%       x - abscissas
%

    x = -cos((1:n)*pi/n);
    

end