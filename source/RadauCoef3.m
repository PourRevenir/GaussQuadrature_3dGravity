function [x,y,z,W] = RadauCoef3(model,n)
%RadauCoef Calculate Radau quadrature weights and
%abscissas.
%
%   [x,y,z,W] = RadauCoef(model,n)
%
%   Input
%       model - [a1,a2,b1,b2,c1,c2,density]
%       n - [n1,n2,n3]
%   Output
%       W - -Radau quadrature weights
%       x,y,z - abscissas
%
    if n(1) == n(2) && n(2) == n(3)
        [w,xi] = RadauCoef(n(1));
       
        wi = 0.5*(model(2)-model(1))*w;
        wj = 0.5*(model(4)-model(3))*w;
        wk = 0.5*(model(6)-model(5))*w;

        x = 0.5*((model(2)-model(1))*xi+model(1)+model(2));
        y = 0.5*((model(4)-model(3))*xi+model(3)+model(4));
        z = 0.5*((model(6)-model(5))*xi+model(5)+model(6));

        [wi,wj,wk] = meshgrid(wi,wj,wk);
        [x,y,z] = meshgrid(x,y,z);
        W = wi.*wj.*wk;
    else
        [wi,x] = RadauCoef(n(1));
        [wj,y] = RadauCoef(n(2));
        [wk,z] = RadauCoef(n(3));
        
        wi = 0.5*(model(2)-model(1))*wi;
        wj = 0.5*(model(4)-model(3))*wj;
        wk = 0.5*(model(6)-model(5))*wk;
        
        x = 0.5*((model(2)-model(1))*x+model(1)+model(2));
        y = 0.5*((model(4)-model(3))*y+model(3)+model(4));
        z = 0.5*((model(6)-model(5))*z+model(5)+model(6));

        [wi,wj,wk] = meshgrid(wi,wj,wk);
        [x,y,z] = meshgrid(x,y,z);
        W = wi.*wj.*wk;
    end

end