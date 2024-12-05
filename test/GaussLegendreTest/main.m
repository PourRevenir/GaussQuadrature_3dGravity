
%++++++++++++++++++++++++++++++++++++++++++++
% Test File As Boot of GuessLegendre Method
%++++++++++++++++++++++++++++++++++++++++++++



model = [-10, 10, -10, 10, -20, -10, 1000];
x = -50:1:50;
y = -50:1:50;
area = [x; y];

% Start Test CuboidGravity Function about gleg "GuessLengndre"
[gx, gy, gz, uxx, uyy, uzz, uxy, uxz, uyz] = CuboidGravity(model, area,"method","gleg");

% result print
disp('gx:');
disp(gx);
disp('gy:');
disp(gy);
disp('gz:');
disp(gz);
disp('uxx:');
disp(uxx);
disp('uyy:');
disp(uyy);
disp('uzz:');
disp(uzz);
disp('uxy:');
disp(uxy);
disp('uxz:');
disp(uxz);
disp('uyz:');
disp(uyz);