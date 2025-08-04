clear;
clc;


% t=cputime;
% rho=2000;

dx=10;dy=10;dz=100;
xp=-400+dx/2:dx:400-dx/2;
yp=-400+dy/2:dy:400-dy/2;
% [xp,yp]=meshgrid(xp,yp);

zp=0;

[Xp,Yp,Zp]=meshgrid(xp,yp,zp);

ObsPoints=[Xp(:) Yp(:) Zp(:)];


%source  源所在位置[-50 50]*[-50 50]*[50 150]
%每个长方体单元的中心
% dx=10;dy=10;dz=10;
x=-400+dx/2:dx:400-dx/2;
y=-400+dy/2:dy:400-dy/2;
z= 50+dz/2:dz:150-dz/2;

%%  Model
density=zeros(length(y),length(x),length(z));
for i=1:length(x)
    for j=1:length(y)
        for k=1:length(z)
            if x(i)>=-50 && x(i)<=50 && y(j)>=-50 && y(j)<=50 && z(k)>=50 && z(k)<=150
                density(j,i,k)=2000;
            end
        end
    end
end


% [X,Y,Z]=meshgrid(x,y,z);
% X=X(:);
% Y=Y(:);
% Z=Z(:);
% 
% x1=X-dx/2;
% x2=X+dx/2;
% 
% paramCoords=[X-dx/2 X+dx/2 Y-dy/2 Y+dy/2 Z-dz/2 Z+dz/2];

for k=1:length(z)
    paramCoords(k,:)=[x(1)-dx/2, x(1)+dx/2, y(1)-dy/2, y(1)+dy/2, z(k)-dz/2, z(k)+dz/2];
end




  tic;

  gz=zeros(length(xp)*length(yp),1);
  for k=1:length(z)
      [ F] = ForwardMatrix_gz(ObsPoints, paramCoords(k,:));
      j=length(xp);
      for i=1:length(yp)
          GG(:,:,i)=toeplitz(F((i-1)*j+1:i*j));
          block_row{i}=GG(:,:,i);
      end
      B = bttb(block_row, block_row);
      density_new=density(:,:,k);
      density_new=density_new(:);
      gz1=B*density_new;
      gz=gz+gz1;
  end

  block_row2=cell(1,length(yp)-1);
  for i=1:length(yp)-1
      block_row2{i}=block_row{length(yp)-i+1};
  end

  C=[];
  for i=1:length(yp)
  C=cat(2,C,block_row{i});
  end

  for i=1:length(yp)-1
      C=cat(2,C,block_row2{i});
  end

  C2=C';
  C2_new=C2(81:end,:);
  CC2=zeros(12640,12720-80);

  C_bottom=cat(2,C2_new,CC2);

  C_all=cat(2,C',C_bottom');

density2=zeros(12720,1);

density2(1:6400,1)=density(:);

%   C2=cat(2,C,C');
% 
  d=ifft2(fft2(C_all).*fft(density2));



time=toc;



 gz=gz*10^5;


gz1=reshape(gz,length(yp),length(xp));

% subplot(311)
contourf(xp,yp,gz1,12)
xlabel('x(m)');
ylabel('y(m)');
axis image
colormap('jet')
colorbar;
title('BTTB方法')


%  gz2=B*density;
% 
%  gz2=gz2*10^5;
% 
% gz2=reshape(gz2,length(yp),length(xp));
% 
% subplot(312)
% contourf(xp,yp,gz2,12)
% xlabel('x(m)');
% ylabel('y(m)');
% axis image
% colormap('jet')
% colorbar;
% title('BTTB方法')
% 
% subplot(313)
% contourf(xp,yp,(gz2-gz1)./gz1,12)
% xlabel('x(m)');
% ylabel('y(m)');
% axis image
% colormap('jet')
% colorbar;
% title('Relative error')




