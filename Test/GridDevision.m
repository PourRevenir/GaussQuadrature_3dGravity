function octree = GridDevision(Model, n, volume)
%GridDevision Devide the model into octree.
%
%   octree = GridDevision(Model, n)
%
%   Input
%       Model - model structure
%       n - [n1, n2, n3]
%       volume - [a1, a2, b1, b2, c1, c2]
%
%   Output
%       octree - octree structure
%
arguments
    Model = ReadModel('Saltf@@',[676,676,210])
    n(1,3) {mustBeNumeric(n)} = [676,676,210]
    volume(1,6) {mustBeNumeric(volume)} = [-6760,6760,-6760,6760,-4200, 0]
end


end

function [] = suboctree(FatherNode)

end