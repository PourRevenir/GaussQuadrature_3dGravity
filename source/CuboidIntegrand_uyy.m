function f = CuboidIntegrand_uyy(x,y,z)
%CuboidIntegrand_uyy The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_uyy(x,y,z)
%
%   Input
%       f - uyy
%

    f =@(xi,eta,zeta) (2*(y-eta).^2-(x-xi).^2-(z-zeta).^2)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end