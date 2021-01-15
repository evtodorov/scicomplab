function e = approximationError(T, nx, ny)
%approximationError Compute approximation error
[X,Y]=meshgrid(linspace(0,1,nx+2),linspace(0,1,nx+2));
Texact =  sin(pi*reshape(X(2:end-1,2:end-1),[],1))...
          .*sin(pi*reshape(Y(2:end-1,2:end-1),[],1));
e = sqrt(sum(sum((reshape(T,[],1)-Texact).^2)))/(nx*ny);

end