clearvars

model = [50,-50,50,-50,-150,-50,2000];

area = ObservationPlane(model);
v = CuboidGravity_GaussianQuad(model,area,"method","glob","n",[18,18,18]);
a = CuboidGravity_analytical(model);

E = ErrorCompare(v,a);

PlotGravity(area,E);