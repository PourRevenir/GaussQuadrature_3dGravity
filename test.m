clearvars

model = [-50,50,-50,50,-150,-50,1000];
n = 24*ones(1,3);

v = CuboidGravity_GaussRadau(model,ObservationPlane(model),n);