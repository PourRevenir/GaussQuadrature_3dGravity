function I = GaussianQuad3(f,x,y,z,W)
%GaussianQuad3 Computing triple integrals of the  function using
%              Gaussian quadrature.
%   
%   I = GaussianQuad3(f,x,y,z,W)
%   
%   Input
%       f - function to be computed
%       x,y,z - Gaussian points
%       W - Gaussian weights
%       
%   Output
%       I - integrals of the function
%s

    I = W.*feval(f,x,y,z);
    I = sum(I(:));

end