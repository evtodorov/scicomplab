function yhat = HeatEquation(Nx,Ny)
%initialize A
A=zeros(Nx,Ny);
%Define variables
hx=1/(Nx+1);
hy=1/(Ny+1);
%Create A matrix
for i=2:Nx+1
    for j=2:Ny+1
    A(i-1,j)=1/(hx^2);
    A(i,j)=-2/(hx^2)-2/(hy^2);
    A(i+1,j)=1/(hx^2);
    A(i,j-1)=1/(hy^2);
    A(i,j+1)=1/(hy^2);
    end
end

