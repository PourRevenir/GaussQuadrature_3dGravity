function [gxx, gxy, gyy, gzx, gyz, gzz] = prismgrad(x, y, z, d, xpos, ypos, zpos)
G = 6.67384e-6;   % Define Gravitational constant
c = G*d;  % multiplication of gravitational constant and density 
% Predifed output parameters
gxx = zeros(size(x));
gxy = zeros(size(x));
gyy = zeros(size(x));
gzx = zeros(size(x));
gyz = zeros(size(x));
gzz = zeros(size(x));
val1 = zeros(size(x));
val2 = zeros(size(x));
% for the calculation of gravity effects due to all surfaces and corners of
% body
% computing the GGT components starting point
for i=1:2
    for j=1:2
        for k=1:2
            r=((x-xpos(i)).^2+(y-ypos(j)).^2+(z-zpos(k)).^2).^0.5;
            if mod(i+j+k,2)==0
                s=1;
            else
                s=-1;
            end
            valuexx = G*d*s*(atan(((x-xpos(i)).*(y-ypos(j)))./((x-xpos(i)).^2+(z-zpos(k)).*r+(z-zpos(k)).^2)));
            valuexy = G*d*s*(log(r+z-zpos(k)));
            valueyy = G*d*s*(atan(((x-xpos(i)).*(y-ypos(j)))./(r.^2+(z-zpos(k)).*r-(x-xpos(i)).^2)));
            valuezx = G*d*s.*(0.5*log((r-(y-ypos(j)))./(r+(y-ypos(j)))));
            valueyz = G*d*s.*(0.5*log((r-(x-xpos(i)))./(r+(x-xpos(i)))));
            valuezz =-G*d*s*atan((x-xpos(i)).*(y-ypos(j))./((z-zpos(k)).*r));
            value1 = ((valuezx.^2)*10^3 + (valueyz.^2)*10^3);
            value2 = ((valuezx.^2)*10^3 + (valueyz.^2)*10^3 + (valuezz.^2)*10^3);
            gxx = gxx + valuexx;
            gxy = gxy + valuexy;
            gyy = gyy + valueyy;
            gzx = gzx + valuezx;
            gyz = gyz + valueyz;
            gzz = gzz + valuezz;
            val1 = val1 + (value1).^0.5;
            val2 = val2 + (value2).^0.5;
        end
    end
end
  

