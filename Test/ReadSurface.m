function Model = ReadSurface(modelfile,n)
% ReadSurface Read the Surface file
% 
%   Surface = ReadSurface(modelfile,n)
%   
%   Input
%       modelfile - model file
%       nx - number of cells in x direction
%       ny - number of cells in y direction
%       nz - number of cells in z direction
%
%   Output
%       Surface - model structure
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
    density(density >= 4000) = 1;

    % Create 3D kernel for edge detection
    kernel = ones(3,3,3);
    kernel(2,2,2) = 0;  % Set center element to 0
    % Perform convolution
    conv_result = convn(density, kernel, 'same');
    % Create a new matrix for edge detection result
    edges = density;
    % Mark edge elements (elements with at least one 0 in their neighborhood)
    edges(conv_result == 26) = 0;  % Internal points
    edges(conv_result < 26) = 1;   % Edge points
    edges(density == 0) = 0;      % Background
    
    % find the non-zero edge values
    [x, y, z] = ind2sub(size(edges), find(edges ~= 0));
    x = (x - 1) * 20 - 6760;
    y = (y - 1) * 20 - 6760;
    z = (z - 1) * 20;

    Model = [x, y, z];
    
end