function f = CuboidIntegrand_gx(x,y,z)
%CuboidIntegrand_gx The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_gx(x,y,z)
%
%   Input
%       f - gx
%

    f =@(xi,eta,zeta) (xi-x)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^3;

end