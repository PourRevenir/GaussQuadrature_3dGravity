function f = Integrand_uxz(x,y,z)
%Integrand_uxz The integrand function of gravity forward calculation.
%
%   f = Integrand_uxz(x,y,z)
%
%   Input
%       f - uxz
%

    f =@(xi,eta,zeta) 3*(x-xi).*(z-zeta)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end