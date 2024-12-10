function f = CuboidIntegrand_gy(x,y,z)
%CuboidIntegrand_gy The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_gy(x,y,z)
%
%   Input
%       f - gy
%

    f =@(xi,eta,zeta) (eta-y)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^3;

end