function [x,y,z,wi,wj,wk] = GaussLobattoCoef3(model,n)
    %GaussLobattoCoef Calculate Gauss-Lobatto quadrature coefficients and
    %Gaussian points.
    %
    %   [x,y,z,wi,wj,wk] = GaussLobattoCoef(model,n)
    %
    %   Input
    %       model - [a1,a2,b1,b2,c1,c2,density]
    %       n - [n1,n2,n3]
    %   Output
    %       wi,wj,wk - Gauss-Lobatto quadrature coefficients
    %       x,y,z - Gaussian points
    %
    
        [wi,x] = GaussLobattoCoef(n(1));
        [wj,y] = GaussLobattoCoef(n(2));
        [wk,z] = GaussLobattoCoef(n(3));
    
        wi = 0.5*(model(2)-model(1))*wi;
        wj = 0.5*(model(4)-model(3))*wj;
        wk = 0.5*(model(6)-model(5))*wk;
    
        x = 0.5*((model(2)-model(1))*x+model(1)+model(2));
        y = 0.5*((model(4)-model(3))*y+model(3)+model(4));
        z = 0.5*((model(6)-model(5))*z+model(5)+model(6));
    
    end