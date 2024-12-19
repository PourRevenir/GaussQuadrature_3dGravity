function PlotGravity(area,values,Colormap)
%PlotGravity Plot maps of gravity anomalies are drawn.
%   
%   PlotGravity(area,values)
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
    
    figure('Name','Gravity anomaly of cuboid')

    subplot(4,3,1)
    imagesc(x,y,values{1})
    gx = gca;
    gx.XLabel.String = 'x(m)';
    gx.YLabel.String = 'y(m)';
    gx.Title.String = 'Error of g_x(mGal)';
    gx.YDir = 'normal';
    gx.FontName = 'Times New Roman';
    gx.FontSize = 11;
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,2)
    imagesc(x,y,values{2})
    gy = gca;
    gy.XLabel.String = 'x(m)';
    gy.YLabel.String = 'y(m)';
    gy.Title.String = 'Error of g_y(mGal)';
    gy.YDir = 'normal';
    gy.FontName = 'Times New Roman';
    gy.FontSize = 11;
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,3)
    imagesc(x,y,values{3})
    gz = gca;
    gz.XLabel.String = 'x(m)';
    gz.YLabel.String = 'y(m)';
    gz.Title.String = 'Error of g_z(mGal)';
    gz.YDir = 'normal';
    gz.FontName = 'Times New Roman';
    gz.FontSize = 11;
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,4)
    imagesc(x,y,values{4})
    uxx = gca;
    uxx.XLabel.String = 'x(m)';
    uxx.YLabel.String = 'y(m)';
    uxx.Title.String = 'Error of U_x_x(E)';
    uxx.YDir = 'normal';
    uxx.FontName = 'Times New Roman';
    uxx.FontSize = 11;
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,5)
    imagesc(x,y,values{5})
    uxy = gca;
    uxy.XLabel.String = 'x(m)';
    uxy.YLabel.String = 'y(m)';
    uxy.Title.String = 'Error of U_x_y(E)';
    uxy.YDir = 'normal';
    uxy.FontName = 'Times New Roman';
    uxy.FontSize = 11;
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,6)
    imagesc(x,y,values{6})
    uxz = gca;
    uxz.XLabel.String = 'x(m)';
    uxz.YLabel.String = 'y(m)';
    uxz.Title.String = 'Error of U_x_z(E)';
    uxz.YDir = 'normal';
    uxz.FontName = 'Times New Roman';
    uxz.FontSize = 11;
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,8)
    imagesc(x,y,values{7})
    uyy = gca;
    uyy.XLabel.String = 'x(m)';
    uyy.YLabel.String = 'y(m)';
    uyy.Title.String = 'Error of U_y_y(E)';
    uyy.YDir = 'normal';
    uyy.FontName = 'Times New Roman';
    uyy.FontSize = 11;
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,9)
    imagesc(x,y,values{8})
    uyz = gca;
    uyz.XLabel.String = 'x(m)';
    uyz.YLabel.String = 'y(m)';
    uyz.Title.String = 'Error of U_y_z(E)';
    uyz.YDir = 'normal';
    uyz.FontName = 'Times New Roman';
    uyz.FontSize = 11;
    colorbar
    colormap(cmap)
    axis image

    subplot(4,3,12)
    imagesc(x,y,values{9})
    uzz = gca;
    uzz.XLabel.String = 'x(m)';
    uzz.YLabel.String = 'y(m)';
    uzz.Title.String = 'Error of U_z_z(E)';
    uzz.YDir = 'normal';
    uzz.FontName = 'Times New Roman';
    uzz.FontSize = 11;
    colorbar
    colormap(cmap)
    axis image
end