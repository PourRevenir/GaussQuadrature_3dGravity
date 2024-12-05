function [x,y,z,wi,wj,wk] = GaussChebyshevCoef3(model,n)
%GaussChebyshevCoef Calculate Gauss-Chebyshev quadrature coefficients and
%Gaussian points.
%
%   [x,y,z,wi,wj,wk] = GaussChebyshevCoef(model,n)
%
%   Input
%       model - [a1,a2,b1,b2,c1,c2,density]
%       n - [n1,n2,n3]
%   Output
%       wi,wj,wk - Gauss-Chebyshev quadrature coefficients
%       x,y,z - Gaussian points
%

    [wi,x] = GaussLegendreCoef(n(1));
    [wj,y] = GaussLegendreCoef(n(2));
    [wk,z] = GaussLegendreCoef(n(3));

    wi = 0.5*(model(2)-model(1))*wi.*sqrt(1-x.^2);
    wj = 0.5*(model(4)-model(3))*wj.*sqrt(1-y.^2);
    wk = 0.5*(model(6)-model(5))*wk.*sqrt(1-z.^2);

    x = 0.5*((model(2)-model(1))*x+model(1)+model(2));
    y = 0.5*((model(4)-model(3))*y+model(3)+model(4));
    z = 0.5*((model(6)-model(5))*z+model(5)+model(6));
end