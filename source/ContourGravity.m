function ContourGravity(area,values,Colormap)
%ContourGravity Contour maps of gravity anomalies are drawn.
%   
%   ContourGravity(area,values)
%
%   Input
%       area - [x;y] x,y is a row vector
%       values - {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};
%
arguments
    area(2,:) {mustBeNumeric(area)}
    values
    Colormap(1,1) string = 'plasma'
end

    x = area(1,:);
    y = area(2,:);
    [xx,yy] = meshgrid(x,y);

    cmap = strcat(Colormap,'.txt');
    cmap = load(cell2mat(cmap));
   
    figure
    subplot(4,3,1)
    contourf(xx,yy,values{1})
    xlabel('x/m')
    ylabel('y/m')
    title('gx')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,2)
    contourf(xx,yy,values{2})
    xlabel('x/m')
    ylabel('y/m')
    title('gy')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,3)
    contourf(xx,yy,values{3})
    xlabel('x/m')
    ylabel('y/m')
    title('gz')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,4)
    contourf(xx,yy,values{4})
    xlabel('x/m')
    ylabel('y/m')
    title('uxx')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,5)
    contourf(xx,yy,values{5})
    xlabel('x/m')
    ylabel('y/m')
    title('uxy')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,6)
    contourf(xx,yy,values{6})
    xlabel('x/m')
    ylabel('y/m')
    title('uxz')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,8)
    contourf(xx,yy,values{7})
    xlabel('x/m')
    ylabel('y/m')
    title('uyy')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,9)
    contourf(xx,yy,values{8})
    xlabel('x/m')
    ylabel('y/m')
    title('uyz')
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,12)
    contourf(xx,yy,values{9})
    xlabel('x/m')
    ylabel('y/m')
    title('uzz')
    colorbar
    colormap(cmap)
    axis image
end