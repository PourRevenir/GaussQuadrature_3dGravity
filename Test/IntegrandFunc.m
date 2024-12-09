function Integrand = IntegrandFunc(object,x,y,z)
%IntegranFunc The integrand function required for forward quadrative
%calculation of cuboid three-dimensional gravity anomaly is provided.
%   
%   Integrand = IntegrandFunc(object,x,y,z)
%
%   Input
%       object - The object to be evaluated, include
%           'gx','gy','gz','uxx','uyy','uzz','uxy','uxz','uyz'
%       x, y, z - The coordinates of the point where the gravity value is
%           required
%
%   Output
%       Integrand - Return a matlab function
%

    switch object
        case 'gx'
            Integrand =@(xi,eta,zeta) (xi-x)./((x-xi).^2+(y-eta).^2+(z-zeta).^2).^1.5;
        case 'gy'
            Integrand =@(xi,eta,zeta) (eta-y)./((x-xi).^2+(y-eta).^2+(z-zeta).^2).^1.5;
        case 'gz'
            Integrand =@(xi,eta,zeta) (zeta-z)./((x-xi).^2+(y-eta).^2+(z-zeta).^2).^1.5;
        case 'uxx'
            Integrand =@(xi,eta,zeta) (2*(x-xi).^2-(y-eta).^2-(z-zeta).^2)./((x-xi).^2+(y-eta).^2+(z-zeta).^2).^2.5;
        case 'uyy'
            Integrand =@(xi,eta,zeta) (2*(y-eta).^2-(x-xi).^2-(z-zeta).^2)./((x-xi).^2+(y-eta).^2+(z-zeta).^2).^2.5;
        case 'uzz'
            Integrand =@(xi,eta,zeta) (2*(z-zeta).^2-(y-eta).^2-(x-xi).^2)./((x-xi).^2+(y-eta).^2+(z-zeta).^2).^2.5;
        case 'uxy'
            Integrand =@(xi,eta,zeta) 3*(x-xi).*(y-eta)./((x-xi).^2+(y-eta).^2+(z-zeta).^2).^2.5;
        case 'uxz'
            Integrand =@(xi,eta,zeta) 3*(x-xi).*(z-zeta)./((x-xi).^2+(y-eta).^2+(z-zeta).^2).^2.5;
        case 'uyz'
            Integrand =@(xi,eta,zeta) 3*(z-zeta).*(y-eta)./((x-xi).^2+(y-eta).^2+(z-zeta).^2).^2.5;
    end

end