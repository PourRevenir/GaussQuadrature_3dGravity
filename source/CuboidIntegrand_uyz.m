function f = CuboidIntegrand_uyz(x,y,z)
%CuboidIntegrand_uyz The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_uyz(x,y,z)
%
%   Input
%       f - uyz
%

    f =@(xi,eta,zeta) 3*(z-zeta).*(y-eta)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end