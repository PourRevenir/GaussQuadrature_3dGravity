function [w,x] = LobattoCoef(n)
%LobattoCoef Calculate Lobatto quadrature weights and
%            free abscissas.
%
%   [w,x] = LobattoCoef(n)
%
%   Input
%       n - number of free abscissas
%   Output
%       w - -Lobatto quadrature weights
%       x - free abscissas
%

    n1=n+1;
    x=cos(pi*(0:n)/n)';
    P=zeros(n1,n1);
    xold=2;
    while max(abs(x-xold))>eps
        xold=x;
        P(:,1)=1;
        P(:,2)=x;
        for k=2:n
            P(:,k+1)=( (2*k-1)*x.*P(:,k)-(k-1)*P(:,k-1) )/k;
        end
        x=xold-( x.*P(:,n1)-P(:,n) )./( n1*P(:,n1) );      
    end
    x=-x;
    w=2./(n*n1*P(:,n1).^2);

end