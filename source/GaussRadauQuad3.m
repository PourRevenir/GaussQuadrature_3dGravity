function I = GaussRadauQuad3(func,x,y,z,W)
%GaussRadauQuad3 Computing triple integrals of the  function using
%Gauss-Radau quadrature.
%   
%   I = GaussRadauQuad3(func,a1,a2,b1,b2,c1,c2,n1,n2,n3)
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