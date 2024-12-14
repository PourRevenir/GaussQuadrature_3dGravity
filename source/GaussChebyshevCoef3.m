function [x,y,z,W] = GaussChebyshevCoef3(model,n)
%GaussChebyshevCoef Calculate Gauss-Chebyshev quadrature weights and
%optimal abscissas.
%
%   [x,y,z,W] = GaussChebyshevCoef(model,n)
%
%   Input
%       model - [a1,a2,b1,b2,c1,c2,density]
%       n - [n1,n2,n3]
%   Output
%       W - Gauss-Chebyshev quadrature weights
%       x,y,z - optimal abscissas
%
    if n(1) == n(2) && n(2) == n(3)
        [w,xi] = GaussChebyshevCoef(n(1));
        r = sqrt(1-xi.^2);
        wi = 0.5*(model(2)-model(1))*w.*r;
        wj = 0.5*(model(4)-model(3))*w.*r;
        wk = 0.5*(model(6)-model(5))*w.*r;

        x = 0.5*((model(2)-model(1))*xi+model(1)+model(2));
        y = 0.5*((model(4)-model(3))*xi+model(3)+model(4));
        z = 0.5*((model(6)-model(5))*xi+model(5)+model(6));

        [wi,wj,wk] = meshgrid(wi,wj,wk);
        [x,y,z] = meshgrid(x,y,z);
        W = wi.*wj.*wk;
    else
        [wi,x] = GaussChebyshevCoef(n(1));
        [wj,y] = GaussChebyshevCoef(n(2));
        [wk,z] = GaussChebyshevCoef(n(3));

        wi = 0.5*(model(2)-model(1))*wi.*sqrt(1-x.^2);
        wj = 0.5*(model(4)-model(3))*wj.*sqrt(1-y.^2);
        wk = 0.5*(model(6)-model(5))*wk.*sqrt(1-z.^2);

        x = 0.5*((model(2)-model(1))*x+model(1)+model(2));
        y = 0.5*((model(4)-model(3))*y+model(3)+model(4));
        z = 0.5*((model(6)-model(5))*z+model(5)+model(6));

        [wi,wj,wk] = meshgrid(wi,wj,wk);
        [x,y,z] = meshgrid(x,y,z);
        W = wi.*wj.*wk;
    end

end