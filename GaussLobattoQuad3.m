function I = GaussLobattoQuad3(func,a1,a2,b1,b2,c1,c2,n1,n2,n3)
%GaussLobattoQuad3 Computing triple integrals of the  function using
%Gauss-Lobatto quadrature.
%   
%   I = GaussLobattoQuad3(func,a1,a2,b1,b2,c1,c2,n1,n2,n3)
%   
%   Input
%       func - function to be computed
%       a1,a2,b1,b2,c1,c2 - model parameter
%       n1,n2,n3 - number of Gaussian points
%       
%   Output
%       I - integrals of the function
%

[wi,x] = GaussLobattoCoef(n1);
[wj,y] = GaussLobattoCoef(n2);
[wk,z] = GaussLobattoCoef(n3);

wi = 0.5*(a2-a1)*wi;
wj = 0.5*(b2-b1)*wj;
wk = 0.5*(c2-c1)*wk;

x = 0.5*((a2-a1)*x+a1+a2);
y = 0.5*((b2-b1)*y+b1+b2);
z = 0.5*((c2-c1)*z+c1+c2);

[wi,wj,wk] = meshgrid(wi,wj,wk);
[x,y,z] = meshgrid(x,y,z);

I = wi.*wj.*wk.*func(x,y,z);
I = sum(I(:));

end