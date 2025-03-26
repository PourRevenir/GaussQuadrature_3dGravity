% Copyright(c) 2025, Central South University. All rights reserved.
% coding: utf-8
%
% programming by Yaokun Yang, Department of Applied Geophiscs, Central South University
% Feburary 26, 2025
% ----------------------------------------------------------
% This program is used to run on the csu-hpc platform
% For more information, please contact the email: yangyaokun@csu.edu.cn
%

clc
clearvars

% ----------------------------------------------------------
% read the model file
Model = ReadModel;

% get the nodes coordinates and the wights of Gauss-Legendre quadrature
model_1 = [Model(1, 1)-10, Model(1, 1)+10, Model(1, 2)-10, Model(1, 2)+10, Model(1, 3)-10, Model(1, 3)+10];
[x, y, z, W] = GaussianCoef3(model_1, 5*ones(1, 3), 'gl');
clearvars model_1

% get the distance between the nodes and the first node
delta_x = Model(:, 1) - Model(1, 1);
delta_y = Model(:, 2) - Model(1, 2);
delta_z = Model(:, 3) - Model(1, 3);
clearvars Model

% set the observation points
observe_x = -7000:140:7000;
observe_y = -7000:140:7000;
observe_z = 5000;
nx = length(observe_x);
ny = length(observe_y);
[observe_X, observe_Y] = meshgrid(observe_x, observe_y);
clearvars observe_x observe_y

% open the parallel pool
p = parpool('local', 20);

% use GPU array
observe_X = gpuArray(observe_X);
observe_Y = gpuArray(observe_Y);
x = gpuArray(x);
y = gpuArray(y);
z = gpuArray(z);
W = gpuArray(W);
delta_x = gpuArray(delta_x);
delta_y = gpuArray(delta_y);
delta_z = gpuArray(delta_z);

% calculate the gravity anomalies
G = 6.67408e-6 * 500;

gx = gpuArray.zeros(nx, ny);
gy = gpuArray.zeros(nx, ny);
gz = gpuArray.zeros(nx, ny);
uxx = gpuArray.zeros(nx, ny);
uxy = gpuArray.zeros(nx, ny);
uxz = gpuArray.zeros(nx, ny);
uyy = gpuArray.zeros(nx, ny);
uyz = gpuArray.zeros(nx, ny);
uzz = gpuArray.zeros(nx, ny);

parfor i = 1:3186452
    xi = x + delta_x(i);
    yj = y + delta_y(i);
    zk = z + delta_z(i);

    gx = gx + arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_gx(x, y, observe_z), xi, yj, zk, W), observe_X, observe_Y);
    gy = gy + arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_gy(x, y, observe_z), xi, yj, zk, W), observe_X, observe_Y);
    gz = gz + arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_gz(x, y, observe_z), xi, yj, zk, W), observe_X, observe_Y);
    uxx = uxx + arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uxx(x, y, observe_z), xi, yj, zk, W), observe_X, observe_Y);
    uxy = uxy + arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uxy(x, y, observe_z), xi, yj, zk, W), observe_X, observe_Y);
    uxz = uxz + arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uxz(x, y, observe_z), xi, yj, zk, W), observe_X, observe_Y);
    uyy = uyy + arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uyy(x, y, observe_z), xi, yj, zk, W), observe_X, observe_Y);
    uyz = uyz + arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uyz(x, y, observe_z), xi, yj, zk, W), observe_X, observe_Y);
    uzz = uzz + arrayfun(@(x, y) GaussianQuad3(CuboidIntegrand_uzz(x, y, observe_z), xi, yj, zk, W), observe_X, observe_Y);
end

gx = Gp*gather(gx);
gy = Gp*gather(gy);
gz = Gp*gather(gz);
uxx = Gp*1e9*gather(uxx);
uxy = Gp*1e9*gather(uxy);
uxz = Gp*1e9*gather(uxz);
uyy = Gp*1e9*gather(uyy);
uyz = Gp*1e9*gather(uyz);
uzz = Gp*1e9*gather(uzz);

results = {gx, gy, gz, uxx, uxy, uxz, uyy, uyz, uzz};

delete(p)

% save the results
save 'Result.mat' results

% ----------------------------------------------------------
% all the functions used in this program
% ----------------------------------------------------------
function Model = ReadModel(modelfile,n)
% ReadModel Read the model file
% 
%   Model = ReadModel(modelfile,n)
%   
%   Input
%       modelfile - model file
%       nx - number of cells in x direction
%       ny - number of cells in y direction
%       nz - number of cells in z direction
%
%   Output
%       Model - model structure
%
arguments
    modelfile string = 'Saltf@@'
    n(1,3) {mustBeNumeric(n)} = [676,676,210]
end

    % read model file
    fid = fopen(modelfile, 'rb', 'ieee-be');
    data = fread(fid, prod(n), 'float32');
    fclose(fid);

    % reshape model and convert to model structure
    density = reshape(data,n);
    density(density < 4000) = 0;

    % find the non-zero density values
    [x, y, z] = ind2sub(size(density), find(density ~= 0));
    x = (x - 1) * 20 - 6760;
    y = (y - 1) * 20 - 6760;
    z = (z - 1) * 20;

    Model = [x, y, z];
    
end

function [x, y, z, W] = GaussianCoef3(model, n, method)
%GaussianCoef3 Calculate Gaussian quadrature weights and optimal abscissas.
%
%   [x, y, z, W] = GaussianCoef3(model, n, method)
%
%   Input
%       model - [a1, a2, b1, b2, c1, c2, density]
%       n - [n1, n2, n3]
%       method - quadrature method ('gl', 'gc', 'r', 'l')
%   Output
%       W - Gaussian quadrature weights
%       x, y, z - optimal abscissas
%

    % Select the appropriate coefficient function
    switch method
        case 'gl'
            coef = @GaussLegendreCoef;
        case 'gc'
            coef = @GaussChebyshevCoef;
        case 'r'
            coef = @RadauCoef;
        case 'l'
            coef = @LobattoCoef;
        otherwise
            error('Unknown method');
    end

    % Calculate weights and nodes for each dimension
    [wi, xi] = coef(n(1));
    [wj, yj] = coef(n(2));
    [wk, zk] = coef(n(3));

    % Scale weights and nodes to the integration interval
    wi = 0.5 * (model(2) - model(1)) * wi;
    wj = 0.5 * (model(4) - model(3)) * wj;
    wk = 0.5 * (model(6) - model(5)) * wk;

    xi = 0.5 * ((model(2) - model(1)) * xi + model(1) + model(2));
    yj = 0.5 * ((model(4) - model(3)) * yj + model(3) + model(4));
    zk = 0.5 * ((model(6) - model(5)) * zk + model(5) + model(6));

    % Create a meshgrid of the scaled nodes and weights
    [x, y, z] = meshgrid(xi, yj, zk);
    [wi, wj, wk] = meshgrid(wi, wj, wk);

    % Compute the weights
    W = wi .* wj .* wk;

end

function [w,x] = GaussLegendreCoef(n)
%GaussLegendreCoef Calculate Gauss-Legendre quadrature weights and
%                  optimal abscissas.
%
%   [w,x] = GaussLegendreCoef(n)
%
%   Input
%       n - number of optimal abscissas
%   Output
%       w - Gauss-Legendre quadrature weights
%       x - optimal abscissas
%

    beta  = 0.5./sqrt(1-(2*(1:n-1)).^(-2));
    T     = diag(beta,1) + diag(beta,-1);
    [V,D] = eig(T);
    x     = diag(D);
    w     = 2*V(1,:)'.^2;
    
end

function I = GaussianQuad3(func,x,y,z,W)
%GaussianQuad3 Computing triple integrals of the  function using
%              Gaussian quadrature.
%   
%   I = GaussianQuad3(func,x,y,z,W)
%   
%   Input
%       func - function to be computed
%       x,y,z - Gaussian points
%       W - Gaussian weights
%       
%   Output
%       I - integrals of the function
%s

    I = W.*parfeval(func,x,y,z);
    I = sum(I(:));

end

function f = CuboidIntegrand_gx(x,y,z)
%CuboidIntegrand_gx The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_gx(x,y,z)
%
%   Input
%       x,y,z - xi,eta,zeta
%

    f =@(xi,eta,zeta) (xi-x)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^3;

end

function f = CuboidIntegrand_gy(x,y,z)
%CuboidIntegrand_gy The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_gy(x,y,z)
%
%   Input
%       f - gy
%

    f =@(xi,eta,zeta) (eta-y)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^3;

end

function f = CuboidIntegrand_gz(x,y,z)
%CuboidIntegrand_gz The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_gz(x,y,z)
%
%   Input
%       f - gz
%

    f =@(xi,eta,zeta) (zeta-z)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^3;

end

function f = CuboidIntegrand_uxx(x,y,z)
%CuboidIntegrand_uxx The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_uxx(x,y,z)
%
%   Input
%       f - uxx
%

    f =@(xi,eta,zeta) (2*(x-xi).^2-(y-eta).^2-(z-zeta).^2)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end

function f = CuboidIntegrand_uxy(x,y,z)
%CuboidIntegrand_uxx The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_uxy(x,y,z)
%
%   Input
%       f - uxy
%

    f =@(xi,eta,zeta) 3*(x-xi).*(y-eta)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end

function f = CuboidIntegrand_uxz(x,y,z)
%CuboidIntegrand_uxz The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_uxz(x,y,z)
%
%   Input
%       f - uxz
%

    f =@(xi,eta,zeta) 3*(x-xi).*(z-zeta)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end

function f = CuboidIntegrand_uyy(x,y,z)
%CuboidIntegrand_uyy The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_uyy(x,y,z)
%
%   Input
%       f - uyy
%

    f =@(xi,eta,zeta) (2*(y-eta).^2-(x-xi).^2-(z-zeta).^2)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end

function f = CuboidIntegrand_uyz(x,y,z)
%CuboidIntegrand_uyz The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_uyz(x,y,z)
%
%   Input
%       f - uyz
%

    f =@(xi,eta,zeta) 3*(z-zeta).*(y-eta)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end

function f = CuboidIntegrand_uzz(x,y,z)
%CuboidIntegrand_uzz The integrand function of gravity forward calculation.
%
%   f = CuboidIntegrand_uzz(x,y,z)
%
%   Input
%       f - uzz
%

    f =@(xi,eta,zeta) (2*(z-zeta).^2-(y-eta).^2-(x-xi).^2)./sqrt((x-xi).^2+(y-eta).^2+(z-zeta).^2).^5;

end