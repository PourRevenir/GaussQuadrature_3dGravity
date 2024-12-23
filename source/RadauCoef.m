function [w,x] = RadauCoef(n)
%RadauCoef Calculate Radau quadrature weights and
%          free abscissas.
%
%   [w,x] = RadauCoef(n)
%
%   Input
%       n - number of abscissas
%   Output
%       w - -Radau quadrature weights
%       x - free abscissas
%

    x = -cos(2*pi*(0:n-1)/(2*n-1))';
    P = zeros(n,n+1);
    xold = 2;
    k = 2:n;
    while max(abs(x-xold))>eps
        xold = x;
        P(1,:) = (-1).^(0:n);       
        P(k,1) = 1;
        P(k,2) = x(k);
        for j=2:n
            P(k,j+1) = ( (2*j-1)*x(k).*P(k,j)-(j-1)*P(k,j-1) )/j;
        end
        x(k) = xold(k)-((1-xold(k))/n).*(P(k,n)+P(k,n+1))...
                    ./(P(k,n)-P(k,n+1));
    end
    P = P(1:n,1:n);
    w = zeros(n,1);
    w(1) = 2/n^2;
    w(k) = (1-x(k))./(n*P(k,n)).^2;

end