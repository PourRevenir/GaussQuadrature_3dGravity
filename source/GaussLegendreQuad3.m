function I = GaussLegendreQuad3(func,x,y,z,wi,wj,wk)
%GaussLegendreQuad3 Computing triple integrals of the  function using
%Gauss-Legendre quadrature.
%   
%   I = GaussLegendreQuad3(func,a1,a2,b1,b2,c1,c2,n1,n2,n3)
%   
%   Input
%       func - function to be computed
%       a1,a2,b1,b2,c1,c2 - model parameter
%       n1,n2,n3 - number of Gaussian points
%       
%   Output
%       I - integrals of the function
%

[wi,wj,wk] = meshgrid(wi,wj,wk);
[x,y,z] = meshgrid(x,y,z);

I = wi.*wj.*wk.*func(x,y,z);
I = sum(I(:));

end