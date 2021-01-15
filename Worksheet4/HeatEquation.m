function A = HeatEquation(Nx,Ny)
hx=1/(Nx+1);
hy=1/(Ny+1);

%wihtout BC
main_diag = (-2/(hx^2)-2/(hy^2))*ones(Nx*Ny,1);
y_diag_p = ones(Nx*Ny,1)/(hy*hy);
y_diag_m = ones(Nx*Ny,1)/(hy*hy);
x_diag = ones(Nx*Ny,1)/(hx*hx);

% add BC
y_diag_m(Ny:Ny:end)=0;
y_diag_p(Ny+1:Ny:end)=0;

% Construct sparse matrix
A = spdiags([x_diag, y_diag_m, main_diag, y_diag_p, x_diag],...
            [ -Ny  ,   -1  ,     0    ,   1   ,    Ny  ],...
            Nx*Ny, Nx*Ny);
end
