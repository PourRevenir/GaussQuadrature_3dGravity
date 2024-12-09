function f = Integrand_gz(x,y,z)
%Integrand_gz The integrand function of gravity forward calculation.
%
%   f = Integrand_gz(x,y,z)
%
%   Input
%       f - gz
%

    f =@(xi,eta,zeta) (zeta-z)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^3;

end