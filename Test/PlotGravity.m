% plot the figure in paper
% December 23, 2024 by yang

clearvars

model = [-50,50,-50,50,-150,-50,2000];
area = ObservationPlane(model);
x = area(1,:);
y = area(2,:);

cmap = load('viridis.txt');
%% load data
load Data\Data\ErrorByRadau.mat

values = E;

%% plot

figure('Name','Gravity anomaly of cuboid','Position',[157.8,62.6,750.4,712])
fsize = 12;

subplot(4,3,1)
imagesc(x,y,values{1})
gx = gca;
gx.XLabel.String = 'x(m)';
gx.YLabel.String = 'y(m)';
gx.Title.String = 'g_x(mGal)';
gx.YDir = 'normal';
gx.FontName = 'Times New Roman';
gx.FontSize = fsize;
colorbar
colormap(cmap)
axis image

subplot(4,3,2)
imagesc(x,y,values{2})
gy = gca;
gy.XLabel.String = 'x(m)';
gy.YLabel.String = 'y(m)';
gy.Title.String = 'g_y(mGal)';
gy.YDir = 'normal';
gy.FontName = 'Times New Roman';
gy.FontSize = fsize;
colorbar
colormap(cmap)
axis image

subplot(4,3,3)
imagesc(x,y,values{3})
gz = gca;
gz.XLabel.String = 'x(m)';
gz.YLabel.String = 'y(m)';
gz.Title.String = 'g_z(mGal)';
gz.YDir = 'normal';
gz.FontName = 'Times New Roman';
gz.FontSize = fsize;
colorbar
colormap(cmap)
axis image

subplot(4,3,4)
imagesc(x,y,values{4})
uxx = gca;
uxx.XLabel.String = 'x(m)';
uxx.YLabel.String = 'y(m)';
uxx.Title.String = 'U_x_x(E)';
uxx.YDir = 'normal';
uxx.FontName = 'Times New Roman';
uxx.FontSize = fsize;
colorbar
colormap(cmap)
axis image

subplot(4,3,5)
imagesc(x,y,values{5})
uxy = gca;
uxy.XLabel.String = 'x(m)';
uxy.YLabel.String = 'y(m)';
uxy.Title.String = 'U_x_y(E)';
uxy.YDir = 'normal';
uxy.FontName = 'Times New Roman';
uxy.FontSize = fsize;
colorbar
colormap(cmap)
axis image

subplot(4,3,6)
imagesc(x,y,values{6})
uxz = gca;
uxz.XLabel.String = 'x(m)';
uxz.YLabel.String = 'y(m)';
uxz.Title.String = 'U_x_z(E)';
uxz.YDir = 'normal';
uxz.FontName = 'Times New Roman';
uxz.FontSize = fsize;
colorbar
colormap(cmap)
axis image

subplot(4,3,8)
imagesc(x,y,values{7})
uyy = gca;
uyy.XLabel.String = 'x(m)';
uyy.YLabel.String = 'y(m)';
uyy.Title.String = 'U_y_y(E)';
uyy.YDir = 'normal';
uyy.FontName = 'Times New Roman';
uyy.FontSize = fsize;
colorbar
colormap(cmap)
axis image

subplot(4,3,9)
imagesc(x,y,values{8})
uyz = gca;
uyz.XLabel.String = 'x(m)';
uyz.YLabel.String = 'y(m)';
uyz.Title.String = 'U_y_z(E)';
uyz.YDir = 'normal';
uyz.FontName = 'Times New Roman';
uyz.FontSize = fsize;
colorbar
colormap(cmap)
axis image

subplot(4,3,12)
imagesc(x,y,values{9})
uzz = gca;
uzz.XLabel.String = 'x(m)';
uzz.YLabel.String = 'y(m)';
uzz.Title.String = 'U_z_z(E)';
uzz.YDir = 'normal';
uzz.FontName = 'Times New Roman';
uzz.FontSize = fsize;
colorbar
colormap(cmap)
axis image