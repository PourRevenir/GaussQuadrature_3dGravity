function ImagescGravity(area,values,Colormap)
%ImagescGravity Imagesc maps of gravity anomalies are drawn.
%   
%   ImagescGravity(area,values)
%
%   Input
%       area - [x;y] x,y is a row vector
%       values - {gx,gy,gz,uxx,uxy,uxz,uyy,uyz,uzz};
%       Colormap - string, ex: 'plasma'
%
arguments
    area(2,:) {mustBeNumeric(area)}
    values
    Colormap(1,1) string = 'plasma'
end

    x = area(1,:);
    y = area(2,:);

    cmap = strcat(Colormap,'.txt');
    cmap = load(cell2mat(cmap));
   
    figure
    subplot(4,3,1)
    imagesc(x,y,values{1})
    xlabel('x/m')
    ylabel('y/m')
    title('gx')
    colorbar
    colormap(cmap)
    set(gca,'YDir','normal')
    axis image

    subplot(4,3,2)
    imagesc(x,y,values{2})
    xlabel('x/m')
    ylabel('y/m')
    title('gy')
    colorbar
    colormap(cmap)
    set(gca,'YDir','normal')
    axis image

    subplot(4,3,3)
    imagesc(x,y,values{3})
    xlabel('x/m')
    ylabel('y/m')
    title('gz')
    colorbar
    colormap(cmap)
    set(gca,'YDir','normal')
    axis image

    subplot(4,3,4)
    imagesc(x,y,values{4})
    xlabel('x/m')
    ylabel('y/m')
    title('uxx')
    colorbar
    colormap(cmap)
    set(gca,'YDir','normal')
    axis image

    subplot(4,3,5)
    imagesc(x,y,values{5})
    xlabel('x/m')
    ylabel('y/m')
    title('uxy')
    colorbar
    colormap(cmap)
    set(gca,'YDir','normal')
    axis image

    subplot(4,3,6)
    imagesc(x,y,values{6})
    xlabel('x/m')
    ylabel('y/m')
    title('uxz')
    colorbar
    colormap(cmap)
    set(gca,'YDir','normal')
    axis image

    subplot(4,3,8)
    imagesc(x,y,values{7})
    xlabel('x/m')
    ylabel('y/m')
    title('uyy')
    colorbar
    colormap(cmap)
    set(gca,'YDir','normal')
    axis image

    subplot(4,3,9)
    imagesc(x,y,values{8})
    xlabel('x/m')
    ylabel('y/m')
    title('uyz')
    colorbar
    colormap(cmap)
    set(gca,'YDir','normal')
    axis image

    subplot(4,3,12)
    imagesc(x,y,values{9})
    xlabel('x/m')
    ylabel('y/m')
    title('uzz')
    colorbar
    colormap(cmap)
    set(gca,'YDir','normal')
    axis image
end