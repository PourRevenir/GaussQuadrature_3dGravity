clearvars

nx = 676;
ny = 676;
nz = 210;

fid = fopen('Saltf@@', 'rb', 'ieee-be');
data = fread(fid, nx * ny * nz, 'float32');
fclose(fid);
velocity = reshape(data, [nx, ny, nz]);

velocity(velocity < 4000) = 0;
velocity(velocity > 4000) = -200;

figure;
[x, y, z] = ind2sub(size(velocity), find(velocity ~= 0));
scatter3(x, y, z, 10, velocity(velocity ~= 0), 'filled');
colorbar;
title('Modified Velocity Regions');
xlabel('X');
ylabel('Y');
zlabel('Z');