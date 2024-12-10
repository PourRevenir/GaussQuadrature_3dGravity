function f = CuboidIntegrand_uxy(x,y,z)
%CuboidIntegrand_uxx The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_uxy(x,y,z)
%
%   Input
%       f - uxy
%

    f =@(xi,eta,zeta) 3*(x-xi).*(y-eta)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end