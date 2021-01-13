function GaussSeidelSolver(Nx,Ny,b)
b=zeros(nx*ny);
hx=1/(Nx+1);
hy=1/(Ny+1);
%Initial Guesses

X(i)=1
X(i-(ny+2))=1
X(i+(Ny+2))=1
X(i*Ny+j+1)=1
X(i*Ny+j+2)1

%Solve the system of equations for each variable
for i=1:(nx+2)*(ny+2)
    x(i)=0;
    X(i-(Ny+2))=b(i)*hx^2-X(i+(Ny+2))+ 2*X(i)-(X(i-1)-2*X(i)+X(i+1))/hy^2
    X(i*2Ny)=b(i)(X(i*Ny)/hx^2+X(i*3Ny)
    X(i*3Ny)=b(i)*hx/(
    X(i*Ny+j)=b(i)*hx/(
    X(i*Ny+j+1)=
    X(i*Ny+j+2)=
    end
end