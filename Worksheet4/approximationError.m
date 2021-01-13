function e = approximationError(T, nx, ny)
%approximationError Compute approximation error
[X,Y]=meshgrid(linspace(0,1,nx+2),linspace(0,1,nx+2));
Texact =  sin(pi*reshape(X(2:end-1,2:end-1),[],1))...
          .*sin(pi*reshape(Y(2:end-1,2:end-1),[],1));
e = sqrt(sum(sum((T-Texact).^2)))/(nx*ny);
figure;
surf(X(2:end-1,2:end-1),Y(2:end-1,2:end-1),reshape(T,nx,ny));
end