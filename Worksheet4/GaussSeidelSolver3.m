function GaussSeidelSolver3(Nx,Ny)
%b=ones((Nx+2)*(Ny+2),1);
b=[0 0 0 0 5 10 5 9 5 5 7 5 5 5 0 0 0 0 ]'
X=zeros((Nx+2)*(Ny+2),1);
nx=Nx+1;
ny=Ny+1;

hx=1/(Nx+1);
hy=1/(Ny+1);
res=1;
A=zeros(nx*ny,1);
D=zeros(nx*ny,1);
g=0;
%Solve the stem of equations for each variable
while  res>=10^-4 
for i=1:1:nx
   
    
   
    for j=1:1:ny
      X(ny*i)=0;
   X(ny*i+ny)=0;
       X(j)=0;
       X(nx*ny+j)=0;
      
        
        
        a=i*ny+j;
        f=a-(ny);
        c=a+(ny);
        d=a-1;
        e=a+1;
        
  X(d)=(b(d)-((X(f)-2*X(a)+X(c))/hx^2))*hy^2-X(e)+2*X(a);   
    X(e)=(b(e)-((X(f)-2*X(a)+X(c))/hx^2))*hy^2-X(d)+2*X(a);
 X(a)=((b(a)-(X(d)-2*X(a)+X(e))/hy^2)*hx^2-X(c)-X(f))/(-2); 
 X(f)=(b(f)-((X(d)-2*X(a)+X(a+1))/hy^2))*hx^2-X(c)+2*X(a); 
  X(c)=(b(c)-((X(d)-2*X(a)+X(e))/hy^2))*hx^2-X(f)+2*X(a);
  
A(a)=((X(f)-2*X(a)+X(c))/(hx^2)+ (X(d)-2*X(a)+X(e))/(hy^2));
D(a)=b(a)-A(a)
    end


end

 Ritsum= sum(D);
g=g+1;
res=sqrt((1/(Nx*Ny))*(Ritsum)^2)
X
end

