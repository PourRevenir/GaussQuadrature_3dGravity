function I = GaussLegendreQuad3(func,x,y,z,W)
%GaussLegendreQuad3 Computing triple integrals of the  function using
%Gauss-Legendre quadrature.
%   
%   I = GaussLegendreQuad3(func,x,y,z,W)
%   
%   Input
%       func - function to be computed
%       x,y,z - Gaussian points
%       W - Gaussian coefficients
%       
%   Output
%       I - integrals of the function
%

    I = W.*func(x,y,z);
    I = sum(I(:));

end