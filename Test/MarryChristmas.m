% 生成树本体曲面
treeFunc=@(h)[h(1),h(h>0&h<=3).*0+1.5,8-(h(h>3)-3).*0.3636];
[X,Y,Z]=cylinder(treeFunc(0:0.2:25));
% 随机移动树冠上点的位置
Z=Z.*25;
cnt1=1:21;cnt2=16:126;
angle=atan(Y(cnt2,cnt1)./X(cnt2,cnt1));
treeDiffusion=rand(111,21)-0.5;
X(cnt2,cnt1)=X(cnt2,cnt1)+cos(angle).*treeDiffusion;
Y(cnt2,cnt1)=Y(cnt2,cnt1)+sin(angle).*treeDiffusion;
Z(cnt2,cnt1)=Z(cnt2,cnt1)+(rand(111,21)-0.5).*0.5;
X(:,end)=X(:,1);Y(:,end)=Y(:,1);Z(:,end)=Z(:,1);
% 绘制圣诞树
surfl(X,Y,Z,'light');
hold on
% 绘制礼物
drawPresent(2,-4,0,3,3,2);
drawPresent(-4,3,0,2,3,1.5);
drawPresent(5,3,0,4,3,3);
drawPresent(-7,-5,0,5,3,1);
drawPresent(-9,-6,0,2,2,2);
drawPresent(0,4,0,4,3,3);
function drawPresent(dx,dy,dz,scalex,scaley,scalez)
presentX=[0.5 0.5 0.5 0.5 0.5; 0 1 1 0 0; 0 1 1 0 0; 0 1 1 0 0; 0.5 0.5 0.5 0.5 0.5];
presentY=[0.5 0.5 0.5 0.5 0.5; 0 0 1 1 0; 0 0 1 1 0; 0 0 1 1 0; 0.5 0.5 0.5 0.5 0.5];
presentZ=[0 0 0 0 0;0 0 0 0 0; 0.5 0.5 0.5 0.5 0.5; 1 1 1 1 1; 1 1 1 1 1];
randColorMap=cat(3,repmat(rand,[5,5])./2+.5,repmat(rand,[5,5])./2+.5,repmat(rand,[5,5])./2+.5);
surf((presentX*scalex+dx),(presentY*scaley+dy), (presentZ*scalez+dz),'CData',randColorMap);
shading interp
end
ax=gca;hold on;
set(gcf,'Color',[22,32,51]./255);
r=(0.0430:(0.2061/50):0.2491)';
g=(0.2969:(0.4012/50):0.6981)';
b=(0.0625:(0.2696/50):0.3321)';
Cmap=[r,g,b];Cmap(1:6,:)=Cmap(1:6,:).*0+[77,63,5]/265;
% 绘制标题
annotation('textbox',[.45,.86,.1,.1],'String','Merry Christmas','fontsize',23,...
    'fontweight','Bold','FontName','Cambria','HorizontalAlignment','center','Color','w','EdgeColor','none')
% 当前坐标区域修饰
set(ax,'XLim',[-10 10],'YLim',[-10,10],'ZLim',[0,30],'PlotBoxAspectRatio',[1,1,1.2],...
    'XColor','none','YColor','none','ZColor','none','Color',[22,32,51]./255,'View',[-37.5,4],...
    'Colormap',Cmap,'Position',[0,0,1,.9],'Tag',char([100,105,115,112,40,39,20316,32773,...
    58,115,108,97,110,100,97,114,101,114,39,41]));
lighting phong;shading interp;eval(ax.Tag)
plot3(0,0,25.6,'p', 'MarkerSize',24,'MarkerFaceColor',[255,223,153]/255,'MarkerEdgeColor','none','LineWidth', 1);
starLightHdl=scatter3(0,0,25,6000,'o','MarkerFaceColor','w','MarkerEdgeColor','w','MarkerEdgeAlpha',0,'MarkerFaceAlpha', 0.1);
% 绘制圣诞树上的彩灯
lightFuncX=@(h,r,a,z) (h-z)./h.*r.*cos(a.*z);
lightFuncY=@(h,r,a,z) (h-z)./h.*r.*sin(a.*z);
h=25;r=8;
lightZ1=linspace(4,25-4,200);a1=0.3*pi;
lightX1=lightFuncX(h,r*1.4,a1,lightZ1);
lightY1=lightFuncY(h,r*1.4,a1,lightZ1);
plot3(lightX1,lightY1,lightZ1+.1,'.','LineWidth',2,'Color',[253,249,220]/255,'MarkerSize',4)
lightZ1=linspace(4,25-4,45);a1=0.3*pi;
lightX1=lightFuncX(h,r*1.2,a1,lightZ1);
lightY1=lightFuncY(h,r*1.2,a1,lightZ1);
scatter3(lightX1,lightY1,lightZ1+.1,300,'Marker','o','MarkerEdgeColor','none',...
    'MarkerFaceColor',[253,249,220]/255,'MarkerFaceAlpha',.08)
scatter3(lightX1,lightY1,lightZ1+.1,50,'Marker','o','MarkerEdgeColor','none',...
    'MarkerFaceColor',[231,217,129]./255,'MarkerFaceAlpha',.95)
lightZ1=linspace(4,25-5,100);a1=-0.15*pi;
lightX1=lightFuncX(h,r*1.2,a1,lightZ1);
lightY1=lightFuncY(h,r*1.2,a1,lightZ1);
plot3(lightX1,lightY1,lightZ1+.1,'.','LineWidth',2,'Color','w','MarkerSize',4)
lightZ1=linspace(4,25-6,17);a1=-0.15*pi;
lightX1=lightFuncX(h,r*1.2,a1,lightZ1);
lightY1=lightFuncY(h,r*1.2,a1,lightZ1);
scatter3(lightX1,lightY1,lightZ1+.1,300,'Marker','o','MarkerEdgeColor','none',...
    'MarkerFaceColor',[253,249,220]/255,'MarkerFaceAlpha',.08)
scatter3(lightX1,lightY1,lightZ1+.1,70,'Marker','o','MarkerEdgeColor','none',...
    'MarkerFaceColor','w','MarkerFaceAlpha',.8)
% 绘制雪花
snowXYZ1=rand(70,3);
snowXYZ1(:,1:2)=snowXYZ1(:,1:2).*26-13;
snowXYZ1(:,3)=snowXYZ1(:,3).*30;
snowXYZ2=rand(90,3);
snowXYZ2(:,1:2)=snowXYZ2(:,1:2).*26-13;
snowXYZ2(:,3)=snowXYZ2(:,3).*30;
snowHdl1=plot3(snowXYZ1(:,1),snowXYZ1(:,2),snowXYZ1(:,3),'*','Color',[1 1 1]);
snowHdl2=plot3(snowXYZ2(:,1),snowXYZ2(:,2),snowXYZ2(:,3),'.','Color',[.6,.6,.6]);
% 旋转图像、雪花飘落
for i=1:1e8
    starLightHdl.SizeData=6000+sin(i/5).*1000;
    snowXYZ1(:,3)=snowXYZ1(:,3)-.1;snowXYZ2(:,3)=snowXYZ2(:,3)-.01;
    snowXYZ1(snowXYZ1(:,3)<0,3)=30;snowXYZ2(snowXYZ2(:,3)<0,3)=30;
    snowHdl1.XData=snowXYZ1(:,1);snowHdl1.YData=snowXYZ1(:,2);snowHdl1.ZData=snowXYZ1(:,3);
    snowHdl2.XData=snowXYZ2(:,1);snowHdl2.YData=snowXYZ2(:,2);snowHdl2.ZData=snowXYZ2(:,3);
    view([i,4]);
    drawnow;pause(.05)
end
