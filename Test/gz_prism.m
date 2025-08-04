function gz=gz_prism(xp,yp,zp,x1,x2,y1,y2,z1,z2,density)

G=6.67384e-11;
a=[x1,x2];
b=[y1,y2];
c=[z1,z2];
gz=0;
for i=1:2
    for j=1:2
        for k=1:2
            xi=xp-a(i);yj=yp-b(j);zk=zp-c(k);
            rijk=sqrt(xi.^2+yj.^2+zk.^2);
            gz=gz+G.*density*(-1)^(i+j+k)*(zk.*atan(xi.*yj./(zk.*rijk))-xi.*log(yj+rijk)-yj.*log(xi+rijk));
%             gx=gx+G.*density*(-1)^(i+j+k)*(xi.*atan((yj+1e-32).*zk./(xi.*rijk))-yj.*log(zk+rijk+1e-32)-zk.*log(yj+rijk));
%             gy=gy+G.*density*(-1)^(i+j+k)*(yj.*atan(zk.*(xi+1e-32)./(yj.*rijk))-zk.*log(xi+rijk)-xi.*log(zk+rijk+1e-32));
        end
    end
end