function I = GaussChebyshevQuad3(func,a1,a2,b1,b2,c1,c2,n1,n2,n3)
%GaussChebyshevQuad3 Computing triple integrals of the  function using
%Gauss-Chebyshev quadrature.
%   
%   I = GaussChebyshevQuad3(func,a1,a2,b1,b2,c1,c2,n1,n2,n3)
%   
%   Input
%       func - function to be computed
%       a1,a2,b1,b2,c1,c2 - model parameter
%       n1,n2,n3 - number of Gaussian points
%       
%   Output
%       I - integrals of the function
%

[wi,x] = GaussChebyshevCoef(n1);
[wj,y] = GaussChebyshevCoef(n2);
[wk,z] = GaussChebyshevCoef(n3);

wi = 0.5*(a2-a1)*wi;
wj = 0.5*(b2-b1)*wj;
wk = 0.5*(c2-c1)*wk;

[t,u,v] = meshgrid(x,y,z);
r = sqrt(1-t.^2).*sqrt(1-u.^2).*sqrt(1-v.^2);

x = 0.5*((a2-a1)*x+a1+a2);
y = 0.5*((b2-b1)*y+b1+b2);
z = 0.5*((c2-c1)*z+c1+c2);

[wi,wj,wk] = meshgrid(wi,wj,wk);
[x,y,z] = meshgrid(x,y,z);

I = wi.*wj.*wk.*r.*func(x,y,z);
I = sum(I(:));

end