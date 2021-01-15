close all;clear;clc;
%setup
N = [3, 7, 15, 31, 63, 127];
tab_full = table('Size',[2,length(N)-1],...
                'VariableTypes',["string" repmat(["double"],1,length(N)-2)],...
                'VariableNames', ["Nx,Ny" string(N(2:end-1))]);
tab_full(:,1) = [ {"runtime"}; {"storage"};];
tab_sparse = tab_full;
tab_GS = tab_full;

tab_err = table('Size',[2,length(N)],...
                'VariableTypes',["string" repmat(["double"],1,length(N)-1)],...
                'VariableNames', ["Nx,Ny" string(N(2:end))]);
tab_err(:,1) = [ {"error"}; {"error red."};];
for i=1:length(N)
    n=N(i);
    %mesh
    [X,Y]=meshgrid(linspace(0,1,n+2),linspace(0,1,n+2));
    x = reshape(X(2:end-1,2:end-1),[],1);
    y = reshape(Y(2:end-1,2:end-1),[],1);
    b = -2*pi*pi*sin(pi*x).*sin(pi*y);

    %% create matrix
    A_sparse = HeatEquation(n,n);
    if i<6
        %% Full
        A_full = full(A_sparse);
        tic;
        T_full = A_full\b;
        t_full = toc;
        
        T_full_plot = zeros(n+2);
        T_full_plot(2:end-1,2:end-1) = reshape(T_full,n,n);
        figure;
        subplot(2,3,1)
        surf(X,Y,reshape(T_full_plot,n+2,n+2));
        title('Full matrix solution');
        subplot(2,3,4)
        contour(X,Y,reshape(T_full_plot,n+2,n+2));
        colorbar;
        %% Sparse
        tic;
        T_sparse = A_sparse\b;
        t_sparse = toc;
        
        T_sparse_plot = zeros(n+2);
        T_sparse_plot(2:end-1,2:end-1) = reshape(T_sparse,[n,n]);
        subplot(2,3,2)
        surf(X,Y,reshape(T_sparse_plot,n+2,n+2));
        title('Sparse matrix solution');
        subplot(2,3,5)
        contour(X,Y,reshape(T_sparse_plot,n+2,n+2));
        colorbar;
    end
    %% Gauss Seidel
    tic;
    T_GS = GaussSeidelSolver(n,n,b);
    t_GS = toc;
    
    if i<6
        T_GS_plot = zeros(n+2);
        T_GS_plot(2:end-1,2:end-1) = T_GS;
        subplot(2,3,3);
        surf(X,Y,reshape(T_GS_plot,n+2,n+2));
        title('Gaus-Seidel solution');
        subplot(2,3,6);
        contour(X,Y,reshape(T_GS_plot,n+2,n+2));
        colorbar;
        sgtitle(strcat('Nx = Ny = ', num2str(n)));
    end
    %% Tables
    if i>1 && i<6
        tab_full(1,i) = {t_full};
        % Full matrix is square matrix of size Nx*Ny x Nx*Ny
        % storage for vector b is ignored for all methods
        tab_full(2,i) = {n^4}; 
        tab_sparse(1,i) = {t_sparse};
        % Upper boundary for sparse matrix size assuming dictionary of keys
        % storage with keys of type int64
        % storage for vector b is ignored for all methods
        tab_sparse(2,i) = {3*nnz(A_sparse)};
        tab_GS(1,i) = {t_GS};
        % Gauss-Seidel storage is the size of the vector of unknowns 
        % (not including constant storage for implementation)
        % storage for vector b is ignored for all methods
        tab_GS(2,i) = {n*n};
    end
    error = approximationError(T_GS, n, n);
    if i>1
        tab_err(1,i) = {error};
        tab_err(2,i) = {old_error/error};
    end
    old_error = error;
end
tab_full
tab_sparse
tab_GS
tab_err