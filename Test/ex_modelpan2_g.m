clc;
clear all;

%Cubic model

x1 =  -200:5:200;% input('Enter x value  ');  % Define total x distance with spacing
y1 =  -200:5:200;%input('Enter y value  ');    % Define total y distance with spacing

z = 0; %input('Enter z-plane  ');   % the surface where data is computed

rho = 2000; %input('Enter d value  ');    % geological density in gm/cc
[x,y] = meshgrid(x1,y1);
%A = 10^-3; % unit conversion from m to km
%B = 1000;  % unit conversion from mGal/km to E
% Predifed output parameters
% gz1 = zeros(size(x)); 
% gy1 = zeros(size(x));
% gx1 = zeros(size(x));
% Defining the prism model parameters and its edges
%disp('Define the body parameters in meters for eg. xpos(1) = 4000; xpos(2) = 12000; ypos(1) = -2000; ypos(2) = 2000; zpos(1) = -1000; zpos(2) = -3000')
xpos(1) = -50; % input('Enter xpos1  '); % % first corner of body along x-axis
xpos(2) =  50; %input('Enter xpos2  ');   %second corner of body along x-axis
ypos(1) = -50; %input('Enter ypos1  ');  % first corner of body along y-axis
ypos(2) =  50; %input('Enter ypos2  ');  % second corner of body along y-axis
zpos(1) = -50; % input('Enter zpos1  ');  % first corner of body along downward z-axis
zpos(2) = -150; %input('Enter zpos2  ');  % second corner of body along downward z-axis
[gz1, gy1, gx1] = prismgrav(x, y, z, rho, xpos, ypos, zpos);


% load seismic.map;
    
%disp('Results are in mGal and E')  
% plotting the responses
%surf(x*A,y*A,gz1);  % 3D plot
figure(3)
subplot(131)
contourf(x,y,gx1,12); 
xlabel('x(m)');    % title for the horizontal axis
ylabel('y(m)');    % title for the vertical axis
zlabel('Gravity anomaly in mGal');   % title for the anomaly axis
colorbar;
% %colormap('jet');
% colormap(flip(seismic))
title('gx in mGal');   % title for the plot
axis image


subplot(132)
contourf(x,y,gy1,12); 
xlabel('x(m)');    % title for the horizontal axis
ylabel('y(m)');    % title for the vertical axis
zlabel('Gravity anomaly in mGal');   % title for the anomaly axis
colorbar;
%colormap('jet');
% colormap(flip(seismic))
title('gy in mGal');   % title for the plot
axis image


subplot(133)
contourf(x,y,gz1,12); 
xlabel('x(m)');    % title for the horizontal axis
ylabel('y(m)');    % title for the vertical axis
zlabel('Gravity anomaly in mGal');   % title for the anomaly axis
colorbar;
%colormap('jet');
% colormap(flip(seismic))
title('gz in mGal');   % title for the plot
axis image



save model2pan.mat x1 y1 gz1;



