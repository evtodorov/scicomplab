function x = GaussSeidelSolver(Nx,Ny,b)
hx=1/(Nx+1);
hy=1/(Ny+1);
%Initial Guesses
x = zeros((Nx)*(Ny),1);

ax = (Nx+1)^2;
ay = (Ny+1)^2;
aa = -2/hx^2-2/hy^2;
counter = 0;
R = Inf;
while R > 1e-4 && counter < 1e+6
    for i=1:Nx*Ny    
        remain = b(i);   
        if rem(i,Ny)~=0 %top     
            remain = remain - ay*x(i+1);
        end
        if rem(i,Ny)~=1 %bottom
            remain = remain - ay*x(i-1);
        end
        if i <= (Nx-1)*Ny %left
            remain = remain - ax*x(i+Ny);
        end
        if i > Ny % right
            remain = remain - ax*x(i-Ny);
        end
        
        x(i) = remain/aa;  
    end
    s = 0;
    for i=1:Nx*Ny    
        remain = b(i);   
        if rem(i,Ny)~=0 %top     
            remain = remain - ay*x(i+1);
        end
        if rem(i,Ny)~=1 %bottom
            remain = remain - ay*x(i-1);
        end
        if i <= (Nx-1)*Ny %left
            remain = remain - ax*x(i+Ny);
        end
        if i > Ny % right
            remain = remain - ax*x(i-Ny);
        end
        remain = remain - aa*x(i);
        s = s + remain^2;
    end
    counter = counter + 1;
    R = sqrt(s/(Nx*Ny));
end

end