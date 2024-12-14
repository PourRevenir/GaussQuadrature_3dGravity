clearvars

n = 15;
% 
% beta  = sqrt(((2:n-2).^2-1)./(4*(2:n-2).^2-1));
% T     = diag(beta,1) + diag(beta,-1);
% [V,D] = eig(T);
% x     = diag(D);
% w     = 2*V(1,:)'.^2;

polyPrevious = 1;
polyCurrent = [1 0];

for i = 1:n-1
    polyForward = [polyCurrent*(2*i+1)/(i+1) 0];
    polyForward = polyForward - [0 0 polyPrevious*i/(i+1)];
    polyPrevious = polyCurrent;
    polyCurrent = polyForward;
end

polydiv(polyCurrent+[0 polyPrevious],[1 1])
