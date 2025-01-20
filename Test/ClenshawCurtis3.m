function Q = ClenshawCurtis3(f, a, b, n1, n2, n3)
%ClenshawCurtis3D Calculate the triple integral of a function using Clenshaw-Curtis quadrature.
%
%   Q = ClenshawCurtis3D(f, a, b, n1, n2, n3)
%
%   Input
%       f - function handle of the integrand, f(x, y, z)
%       a - 1x3 vector of lower bounds [ax, ay, az]
%       b - 1x3 vector of upper bounds [bx, by, bz]
%       n1 - number of abscissas in x direction
%       n2 - number of abscissas in y direction
%       n3 - number of abscissas in z direction
%   Output
%       Q - approximate value of the triple integral
%

    % Generate Clenshaw-Curtis nodes and weights for each direction
    [wx, xx] = ClenshawCurtisCoef(n1);
    [wy, xy] = ClenshawCurtisCoef(n2);
    [wz, xz] = ClenshawCurtisCoef(n3);

    % Scale nodes to the integration interval
    xx_scaled = 0.5 * ((b(1) - a(1)) * xx + (b(1) + a(1)));
    xy_scaled = 0.5 * ((b(2) - a(2)) * xy + (b(2) + a(2)));
    xz_scaled = 0.5 * ((b(3) - a(3)) * xz + (b(3) + a(3)));

    % Create a meshgrid of the scaled nodes
    [X, Y, Z] = ndgrid(xx_scaled, xy_scaled, xz_scaled);

    % Evaluate the function on the grid
    F = f(X, Y, Z);

    % Compute the triple integral using tensor product of weights
    W = wx * wy' * wz';
    Q = sum(F(:) .* W(:)) * prod((b - a) / 2);

end

function [w, x] = ClenshawCurtisCoef(n)
%ClenshawCurtisCoef Calculate Clenshaw-Curtis quadrature weights and abscissas using FFT.
%
%   [w, x] = ClenshawCurtisCoef(n)
%
%   Input
%       n - number of abscissas
%   Output
%       w - Clenshaw-Curtis quadrature weights
%       x - abscissas
%

    % Compute the abscissas
    x = -cos(pi * (0:n)' / n);

    % Compute the weights using FFT
    c = zeros(n+1, 1);
    c(1) = 2;
    c(2:2:n) = 2 ./ (1 - (2:2:n).^2);
    c(n+1) = 2 / (1 - n^2);

    % Perform the FFT
    w = real(ifft(c));

    % Adjust the weights
    w = w * n / 2;
    w(1) = w(1) / 2;
    w(end) = w(end) / 2;

end