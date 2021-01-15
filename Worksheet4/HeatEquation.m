function A = HeatEquation(Nx,Ny)
hx=1/(Nx+1);
hy=1/(Ny+1);
main_diag = (-2/(hx^2)-2/(hy^2))*ones(Nx*Ny,1);
y_diag_p = ones(Nx*Ny,1)/(hy*hy);
y_diag_p(Ny+1:Ny:end)=0;
y_diag_m = ones(Nx*Ny,1)/(hy*hy);
y_diag_m(Ny:Ny:end)=0;
x_diag = ones(Nx*Ny,1)/(hx*hx);

%wihtout BC
A = spdiags([x_diag, y_diag_m, main_diag, y_diag_p, x_diag],...
            [ -Ny  ,   -1  ,     0    ,   1   ,    Ny  ],...
            Nx*Ny, Nx*Ny);
        
%apply BC
% for i=1:(Nx*Ny)
%     if i < Nx*Ny && rem(i,Ny)==0 % @ top     
%         A(i,i+1) = 0;
%     end
%     if i > 1 && rem(i,Ny)==1 % @ bottom
%         A(i, i-1) = 0;
%     end
%     %left & right are taken care of by the size of the matrix
% end
end
