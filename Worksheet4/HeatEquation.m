function yhat = HeatEquation(Nx,Ny)
%initialize A
nx=Nx+2;
ny=Ny+2;
A=zeros(nx*ny,nx*ny);
%Define variables
hx=1/(Nx+1);
hy=1/(Ny+1);
%Create A matrix
%for i=2:Nx+1
    %for j=2:Ny+1
    %A(i*Nx-Nx-1,j)=1/(hx^2);
    %A(i,j)=-2/(hx^2)-2/(hy^2);
    %A(i+1,j)=1/(hx^2);
    %A(i,j-1)=1/(hy^2);
    %A(i,j+1)=1/(hy^2);
    %end
    
    for i=2:nx-1
    for j=2:ny-1
    equation=(i-1)*ny+j;
   A(equation,equation-1)=1/(hy^2);
   A(equation,equation+1)=1/(hy^2);
   A(equation,equation)=-2/(hx^2)-2/(hy^2);
   A(equation,(i-2)*ny+j)=1/(hx^2);
   A(equation,(i)*ny+j)=1/(hx^2);
    end
end
A
