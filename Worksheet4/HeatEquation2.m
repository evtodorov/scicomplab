function yhat = HeatEquation(Nx,Ny)
%initialize A
nx=Nx+2;
ny=Ny+2;
A=zeros(nx*ny,nx*ny)
%Define variables
hx=1/(Nx+1);
hy=1/(Ny+1);
%Create A matrix

    
   for i=Ny+2:(Ny+2):nx*ny-1
   A(i,i-1)=1/(hy^2);
   A(i,i+1)=1/(hy^2);
   A(i,i)=-2/(hx^2)-2/(hy^2);
   A(i,i-(Ny+1))=1/(hx^2);
   A(i,i+(Ny+1))=1/(hx^2);
    end

A
