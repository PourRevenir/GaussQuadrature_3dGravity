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