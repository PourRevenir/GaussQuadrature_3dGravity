function f = Integrand_uxy(x,y,z)
%Integrand_uxx The integrand function of gravity forward calculation.
%
%   f = Integrand_uxy(x,y,z)
%
%   Input
%       f - uxy
%

    f =@(xi,eta,zeta) 3*(x-xi).*(y-eta)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end