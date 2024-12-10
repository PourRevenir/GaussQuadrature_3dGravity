function ImagescGravity(area,values)
%ImagescGravity Imagesc maps of gravity anomalies are drawn.
%   
%   ImagescGravity(area,values)
%
%   Input
%       area - [x;y] x,y is a row vector
%       values - {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};
%
    x = area(1,:);
    y = area(2,:);
    xx = [x(1),x(end)];
    yy = [y(1),y(end)];

    cmap = load("plasma.txt");
   
    figure
    subplot(4,3,1)
    imagesc(xx,yy,values{1})
    xlabel('x/m')
    ylabel('y/m')
    title('gx')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,2)
    imagesc(xx,yy,values{2})
    xlabel('x/m')
    ylabel('y/m')
    title('gy')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,3)
    imagesc(xx,yy,values{3})
    xlabel('x/m')
    ylabel('y/m')
    title('gz')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,4)
    imagesc(xx,yy,values{4})
    xlabel('x/m')
    ylabel('y/m')
    title('uxx')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,5)
    imagesc(xx,yy,values{5})
    xlabel('x/m')
    ylabel('y/m')
    title('uxy')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,6)
    imagesc(xx,yy,values{6})
    xlabel('x/m')
    ylabel('y/m')
    title('uxz')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,8)
    imagesc(xx,yy,values{7})
    xlabel('x/m')
    ylabel('y/m')
    title('uyy')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,9)
    imagesc(xx,yy,values{8})
    xlabel('x/m')
    ylabel('y/m')
    title('uyz')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,12)
    imagesc(xx,yy,values{9})
    xlabel('x/m')
    ylabel('y/m')
    title('uzz')
    colorbar
    colormap(cmap)
    axis image
end