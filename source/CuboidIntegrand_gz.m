function f = CuboidIntegrand_gz(x,y,z)
%CuboidIntegrand_gz The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_gz(x,y,z)
%
%   Input
%       f - gz
%

    f =@(xi,eta,zeta) (zeta-z)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^3;

end