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

    x=cos(pi*(0:n-1)/(n-1))';
    P=zeros(n,n);
    xold=2;
    while max(abs(x-xold))>eps
        xold=x;
        P(:,1)=1;
        P(:,2)=x;
        for k=2:n-1
            P(:,k+1)=( (2*k-1)*x.*P(:,k)-(k-1)*P(:,k-1) )/k;
        end
        x=xold-( x.*P(:,n)-P(:,n-1) )./( n*P(:,n) );      
    end
    x=-x;
    w=2./((n-1)*n*P(:,n).^2);

end