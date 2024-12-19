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

    n1 = n+1;
    x = -cos(2*pi*(0:n)/(2*n+1))';
    P = zeros(n1,n1+1);
    xold = 2;
    free = 2:n1;
    while max(abs(x-xold))>eps
        xold = x;
        P(1,:) = (-1).^(0:n1);       
        P(free,1) = 1;
        P(free,2) = x(free);
        for k=2:n1
            P(free,k+1) = ( (2*k-1)*x(free).*P(free,k)-(k-1)*P(free,k-1) )/k;
        end
        x(free) = xold(free)-((1-xold(free))/n1).*(P(free,n1)+P(free,n1+1))...
                    ./(P(free,n1)-P(free,n1+1));
    end
    P = P(1:n1,1:n1);
    w = zeros(n1,1);
    w(1) = 2/n1^2;
    w(free) = (1-x(free))./(n1*P(free,n1)).^2;

end