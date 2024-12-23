function E = ErrorCompare(V,A)
%ErrorCompare Compare the error between the two data.
%   
%   E = ErrorCompare(V,A)
%
%   Input
%       V - values 1×9 cell
%       A - analytics 1×9 cell
    
    E = cell(1,9);

    for i = 1:9
        E{i} = V{i} - A{i};
    end
    
end