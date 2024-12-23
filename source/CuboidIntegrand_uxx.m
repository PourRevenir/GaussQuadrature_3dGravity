function f = CuboidIntegrand_uxx(x,y,z)
%CuboidIntegrand_uxx The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_uxx(x,y,z)
%
%   Input
%       f - uxx
%

    f =@(xi,eta,zeta) (2*(x-xi).^2-(y-eta).^2-(z-zeta).^2)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end