function RRMS = ErrorRRMS(E,A)
%ErrorRRMS Calculate RRMS.
%   
%   RRMS = ErrorRRMS(E,A)
%
%   Input:
%       E - error 1×9 cell
%       A - analytics 1×9 cell
%
%   Output:
%       RRMS - RRMS 1×9 array 
%

    RRMS = zeros(1,9);

    for i = 1:9
        e = E{i};
        a = A{i};
        RRMS(i) = sqrt(sum(e(:).^2)./sum(a(:).^2));
    end

end