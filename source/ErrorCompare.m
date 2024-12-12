function E = ErrorCompare(V,A)
%ErrorCompare Compare the error between the two data.
%   
%   E = ErrorCompare(V,A)
%
%   Input
%       
    
    E = cell(1,9);

    for i = 1:9
        E{i} = V{i} - A{i};
    end
    
end