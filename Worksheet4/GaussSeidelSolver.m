function x = GaussSeidelSolver(Nx,Ny,b)
% Gauss-Seidel Solver for stationary Heat Equation on (0,1) 
% Work only for boundary conditions x=0 @ boundary
% Nx and Ny should NOT include the boundary
% x DOES NOT contain the boundary
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
    %loop & update vector
    for i=1:Nx*Ny    
        remain = b(i);  %RHS - LHS
        %remain = handleBC(remain, i, Nx, Ny, x);
        % using the function slows Matlab about 2x... so ugly code it is
        if rem(i,Ny)~=0 % unless @ top     
            remain = remain - ay*x(i+1);
        end
        if rem(i,Ny)~=1 % unless @ bottom
            remain = remain - ay*x(i-1);
        end
        if i <= (Nx-1)*Ny % unless @ right
            remain = remain - ax*x(i+Ny);
        end
        if i > Ny %  unless @ left
            remain = remain - ax*x(i-Ny);
        end
            x(i) = remain/aa;  
    end
    s = 0;
    %loop & calculate remainder
    for i=1:Nx*Ny    
        remain = b(i);   
        %remain = handleBC(remain, i, Nx, Ny, x);
        % using the function slows Matlab about 2x... so ugly code it is
        if rem(i,Ny)~=0 % unless @ top     
            remain = remain - ay*x(i+1);
        end
        if rem(i,Ny)~=1 % unless @ bottom
            remain = remain - ay*x(i-1);
        end
        if i <= (Nx-1)*Ny % unless @ right
            remain = remain - ax*x(i+Ny);
        end
        if i > Ny %  unless @ left
            remain = remain - ax*x(i-Ny);
        end
            remain = remain - aa*x(i);
            s = s + remain^2;
    end
    counter = counter + 1;
    R = sqrt(s/(Nx*Ny));
end
x = reshape(x,Nx,Ny);
end

function remain = handleBC(remain, i, Nx, Ny, x)
% Encode the matrix and boundary conditions as function
% works if and only if the BC are x=0 @ boundary
    ax = (Nx+1)^2;
    ay = (Ny+1)^2;
    if rem(i,Ny)~=0 % unless @ top     
        remain = remain - ay*x(i+1);
    end
    if rem(i,Ny)~=1 % unless @ bottom
        remain = remain - ay*x(i-1);
    end
    if i <= (Nx-1)*Ny % unless @ right
        remain = remain - ax*x(i+Ny);
    end
    if i > Ny %  unless @ left
        remain = remain - ax*x(i-Ny);
    end
end