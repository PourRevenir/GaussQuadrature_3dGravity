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