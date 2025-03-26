% Copyright (c) 2024 by Central South University.                   
% coding: utf-8
% Plot the figure in the paper.                                                     
% Programme written by Y. Yang                            
% For more information, contact by email: <yangyaokun@csu.edu.cn>.  
% Please read the README.md before use.                             
%-------------------------------------------------------------------

fid = fopen('Saltf@@', 'rb', 'ieee-be');
data = fread(fid, prod([676,676,210]), 'float32');
fclose(fid);

% reshape model and convert to model structure
density = reshape(data,[676,676,210]);
density(density < 4000) = 0;
clearvars data
%%

[x,y,z] = meshgrid(-6.75:0.02:6.75,-6.75:0.02:6.75,-4.18:0.02:0);

figure;
slice_x = 0;
slice_y = 0;
slice_z = [];

figure;
h = slice(x,y,z,density, slice_x, slice_y, slice_z);
set(h, 'EdgeColor', 'none');
shading interp;

colorbar;
colormap("jet")
title('Density Model Slices');
xlabel('X');
ylabel('Y');
zlabel('Z');