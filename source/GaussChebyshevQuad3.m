function I = GaussChebyshevQuad3(func,x,y,z,W)
%GaussChebyshevQuad3 Computing triple integrals of the  function using
%Gauss-Chebyshev quadrature.
%   
%   I = GaussChebyshevQuad3(func,x,y,z,W)
%   
%   Input
%       func - function to be computed
%       x,y,z - Gaussian points
%       W - Gaussian coefficients
%       
%   Output
%       I - integrals of the function
%s

    I = W.*func(x,y,z);
    I = sum(I(:));

end