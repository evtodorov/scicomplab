function GaussSeidelSolver(Nx,Ny,b)
b=zeros(Nx*Ny);
hx=1/(Nx+1);
hy=1/(Ny+1);
%Initial Guesses

X(i*2Ny)=1
X(i*3Ny)=1
X(i*Ny+j)=1
X(i*Ny+j+1)=1
X(i*Ny+j+2)1

%Solve the system of equations for each variable
for i=0:nx
    for j=0:Ny+1
    X(i*Ny)=b(i)*hx^2/( 
    X(i*2Ny)=b(i)(X(i*Ny)/hx^2+X(i*3Ny)
    X(i*3Ny)=b(i)*hx/(
    X(i*Ny+j)=b(i)*hx/(
    X(i*Ny+j+1)=
    X(i*Ny+j+2)=
    end
end