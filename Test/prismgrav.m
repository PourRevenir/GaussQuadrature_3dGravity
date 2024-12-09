function [gz1, gy1, gx1] = prismgrav(x, y, z, d, xpos, ypos, zpos)
G = 6.67384e-6;   % Define Gravitational constant
c = G*d;  % multiplication of gravitational constant and density 
% for the calculation of gravity effects due to all surfaces and corners of
% body
%  starting point
gz1 = zeros(size(x)); 
gy1 = zeros(size(x));
gx1 = zeros(size(x));
for i = 1:2
    for j = 1:2
        for k = 1:2
            r = ((x-xpos(i)).^2 + (y-ypos(j)).^2 + (z-zpos(k)).^2).^0.5;
            gz = -c*(-1)^i*(-1)^j*(-1)^k*(((z-zpos(k)).*atan(((x-xpos(i)).*(y-ypos(j)))./((z-zpos(k)).*r))) - ((x-xpos(i)).*log(r+(y-ypos(j))))-((y-ypos(j)).*log(r+x-xpos(i))));
            gy = c*(-1)^i*(-1)^j*(-1)^k*((y-ypos(j)+1e-32).*atan(((z-zpos(k)).*(x-xpos(i)))./(((y-ypos(j)+1e-32).*r))) - ((z-zpos(k)).*log(r+x-xpos(i))+(x-xpos(i)).*log(r+z-zpos(k))));
            gx = c*(-1)^i*(-1)^j*(-1)^k*(((x-xpos(i)).*atan(((y-ypos(j)+1e-32).*(z-zpos(k)))./(((x-xpos(i)).*r))) - ((y-ypos(j)+1e-32).*log(r+(z-zpos(k))))-((z-zpos(k)).*log(r+y-ypos(j)+1e-32))));
            gz1 = gz1 + gz;
            gy1 = gy1 + gy;
            gx1 = gx1 + gx;
        end
    end
end

